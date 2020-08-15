import UIKit
import UI
import Services
import Interactors

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let window = UIWindow(frame: UIScreen.main.bounds)
    var shoppingRouter: ShoppingRouter?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

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
        window.makeKeyAndVisible()

        showLogin(overViewController: shoppingRouterVC, apiService: apiService)

        return true
    }

    private func showLogin(overViewController viewController: UIViewController, apiService: APIService) {
        let loginNavController = UINavigationController()
        loginNavController.setNavigationBarHidden(true, animated: false)

        let loginInteractor = LoginInteractor(apiService: apiService, didLogIn: { [weak apiService, weak loginNavController] in
            guard let apiService = apiService, let loginNavController = loginNavController else { return }

            let addAddressInteractor = AddAddressInteractor(
                apiService: apiService,
                didAddAddress: { [weak loginNavController] in
                    guard let loginNavController = loginNavController else { return }

                    loginNavController.pushViewController(ModulesFactory.makeAddressAddedModule(), animated: true)

                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        loginNavController.dismiss(animated: true, completion: nil)
                    }
                }
            )

            let module = ModulesFactory.makeAddAddressModule(addAddressInteractor: addAddressInteractor)
            loginNavController.pushViewController(module, animated: true)
        })
        let loginModule = ModulesFactory.makeLoginModule(loginInteractor: loginInteractor)

        loginNavController.setViewControllers([loginModule], animated: false)

        viewController.present(loginNavController, animated: true, completion: nil)
    }

    private func showCheckout(overViewController viewController: UIViewController, apiService: APIService, basketInteractor: BasketInteractor) {

        let checkoutInteractor = CheckoutInteractor(
            apiService: apiService,
            didSubmitOrder: { [weak viewController] in
                viewController?.presentedViewController?.dismiss(animated: true, completion: nil)
            }
        )

        let addressesListModule = ModulesFactory.makeCheckoutAddressSelectionModule(
            addressesInteractor: AddressesListInteractor(apiService: apiService),
            checkoutInteractor: checkoutInteractor
        )

        let timesModule = ModulesFactory.makeDeliveryTimesModule(interactor: checkoutInteractor)

        let creditCardModule = ModulesFactory.makeCreditCardInputModule(interactor: checkoutInteractor)

        let basketModule = ModulesFactory.makeBasketModule(
            basketInteractor: basketInteractor,
            showsNavigation: false,
            didSelectCheckout: {}
        )

        let checkoutViewController = ModulesFactory.makeCheckoutModule(
            interactor: checkoutInteractor,
            embeddedViewControllers: [
                ModulesFactory.titleCheckoutModule(viewController: addressesListModule,
                                                   withTitle: "SELECT DELIVERY ADDRESS"),
                ModulesFactory.titleCheckoutModule(viewController: timesModule,
                                                   withTitle: "SELECT DELIVERY TIME"),
                ModulesFactory.titleCheckoutModule(viewController: creditCardModule,
                                                   withTitle: "SPECIFY YOUR PAYMENT CARD"),
                ModulesFactory.titleCheckoutModule(viewController: basketModule,
                                                   withTitle: "REVIEW YOUR ORDER")
            ]
        )

        viewController.present(checkoutViewController, animated: true, completion: nil)
    }
}

