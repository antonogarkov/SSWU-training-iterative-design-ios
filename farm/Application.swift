import UIKit
import UI
import Services
import Interactors

final class Application {
    let window: UIWindow
    let resetCallback: () -> Void

    var shoppingRouter: ShoppingRouter?
    var loginRouter: LoginRouter?
    var checkoutRouter: CheckoutRouter?

    init(window: UIWindow, resetCallback: @escaping () -> Void) {
        self.window = window
        self.resetCallback = resetCallback
    }

    func start() {
        UITabBar.appearance().tintColor = UIColor.black

        let apiService = APIService()

        let basketInteractor = BasketInteractor(apiService: apiService)

        let shoppingRouter = ShoppingRouter(
            basketInteractor: basketInteractor,
            apiService: apiService,
            onShowLogin: { [weak self, weak apiService] in
                guard let rootViewController = self?.window.rootViewController, let apiService = apiService else { return }

                self?.showLogin(overViewController: rootViewController, apiService: apiService)
            },
            onLogout: resetCallback,
            onShowCheckout: { [weak self, weak apiService, weak basketInteractor] in
                guard let rootViewController = self?.window.rootViewController,
                    let apiService = apiService,
                    let basketInteractor = basketInteractor else { return }

                self?.showCheckout(overViewController: rootViewController, apiService: apiService, basketInteractor: basketInteractor)
            }
        )

        self.shoppingRouter = shoppingRouter
        let shoppingRouterVC = shoppingRouter.start()

        window.rootViewController = shoppingRouterVC

        showLogin(overViewController: shoppingRouterVC, apiService: apiService)

    }

    private func showLogin(overViewController viewController: UIViewController, apiService: APIService) {
        let loginRouter = LoginRouter(
            apiService: apiService,
            didFinish: { [weak viewController, weak self] in
                viewController?.presentedViewController?.dismiss(animated: true, completion: nil)
                self?.loginRouter = nil
            }
        )
        self.loginRouter = loginRouter

        viewController.present(loginRouter.start(), animated: true, completion: nil)
    }

    private func showCheckout(overViewController viewController: UIViewController, apiService: APIService, basketInteractor: BasketInteractor) {
        let checkoutRouter = CheckoutRouter(
            apiService: apiService,
            basketInteractor: basketInteractor,
            didFinish: { [weak viewController, weak self] in
                viewController?.presentedViewController?.dismiss(animated: true, completion: nil)
                self?.checkoutRouter = nil
            }
        )
        self.checkoutRouter = checkoutRouter

        viewController.present(checkoutRouter.start(), animated: true, completion: nil)
    }
}
