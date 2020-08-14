import UIKit
import UI
import Services
import Interactors

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let window = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        UITabBar.appearance().tintColor = UIColor.black

        let apiService = APIService()

        let basketInteractor = BasketInteractor(apiService: apiService)

        let tabbarController = UITabBarController()

        tabbarController.tabBar.tintColor = .black
        tabbarController.tabBar.unselectedItemTintColor = UIColor(named: "BrandBlue")

        tabbarController.viewControllers = [
            makeProductsModule(apiService: apiService, basketInteractor: basketInteractor),
            makeAddressesModule(apiService: apiService),
            makeProfileModule(apiService: apiService),
            ModulesFactory.makeBasketModule(
                basketInteractor: basketInteractor,
                didSelectCheckout: { [weak self, weak tabbarController, weak apiService] in
                    guard let self = self, let tabbarController = tabbarController, let apiService = apiService else {
                        return
                    }
                    self.showCheckout(overViewController: tabbarController, apiService: apiService)
                }
            )
        ]

        window.rootViewController = tabbarController
        window.makeKeyAndVisible()

        let loginNavController = UINavigationController()
        loginNavController.setNavigationBarHidden(true, animated: false)

        let loginInteractor = LoginInteractor(apiService: apiService, didLogIn: { [weak apiService, weak loginNavController] in
            guard let apiService = apiService, let loginNavController = loginNavController else { return }

            let addAddressInteractor = AddAddressInteractor(
                apiService: apiService,
                didAddAddress: { [weak loginNavController] in
                    guard let loginNavController = loginNavController else { return }

                    loginNavController.dismiss(animated: true, completion: nil)
                }
            )

            let module = ModulesFactory.makeAddAddressModule(addAddressInteractor: addAddressInteractor)
            loginNavController.pushViewController(module, animated: true)
        })
        let loginModule = ModulesFactory.makeLoginModule(loginInteractor: loginInteractor)

        loginNavController.setViewControllers([loginModule], animated: false)

        tabbarController.present(loginNavController, animated: true, completion: nil)

        return true
    }

    private func showCheckout(overViewController viewController: UIViewController, apiService: APIService) {

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

        let checkoutViewController = ModulesFactory.makeCheckoutModule(
            interactor: checkoutInteractor,
            embeddedViewControllers: [addressesListModule]
        )

        viewController.present(checkoutViewController, animated: true, completion: nil)
    }

    private func makeProductsModule(apiService: APIService,
                                    basketInteractor: BasketInteractor) -> UIViewController {

        let productsInteractor = ProductsListInteractor(apiService: apiService)
        return ModulesFactory.makeProductsModule(productsInteractor: productsInteractor, basketInteractor: basketInteractor)
    }

    private func makeProfileModule(apiService: APIService) -> UIViewController {
        let profileInteractor = ProfileInteractor(apiService: apiService)
        return ModulesFactory.makeProfileModule(profileInteractor: profileInteractor)
    }

    private func makeAddressesModule(apiService: APIService) -> UIViewController {
        let addressesInteractor = AddressesListInteractor(apiService: apiService)
        return ModulesFactory.makeAddressesModule(addressesInteractor: addressesInteractor)
    }
}

