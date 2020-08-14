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

        let addressesNavigationController = UINavigationController()
        addressesNavigationController.setNavigationBarHidden(true, animated: false)

        let addressesViewController = makeAddressesModule(
            apiService: apiService,
            addSelected: {
                let addAddressInteractor = AddAddressInteractor(
                    apiService: apiService,
                    didAddAddress: { [weak addressesNavigationController] in
                        guard let addressesNavigationController = addressesNavigationController else { return }

                        addressesNavigationController.pushViewController(ModulesFactory.makeAddressAddedModule(), animated: true)

                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            addressesNavigationController.popToRootViewController(animated: true)
                        }
                    }
                )

                let module = ModulesFactory.makeAddAddressModule(addAddressInteractor: addAddressInteractor)
                addressesNavigationController.pushViewController(module, animated: true)
            }
        )

        addressesNavigationController.viewControllers = [addressesViewController]

        let tabbarController = UITabBarController()

        tabbarController.tabBar.tintColor = .black
        tabbarController.tabBar.unselectedItemTintColor = UIColor(named: "BrandBlue")

        tabbarController.viewControllers = [
            makeProductsModule(apiService: apiService, basketInteractor: basketInteractor),
            addressesNavigationController,
            makeProfileModule(apiService: apiService, didPresLogout: { [weak self, weak apiService, weak tabbarController] in
                print("PANIC! I DON'T KNOW WHAT TO DO HERE!!")
                guard let tabbarController = tabbarController, let apiService = apiService, let self = self else {
                    return
                }
                apiService.resetSession()
                self.showLogin(overViewController: tabbarController, apiService: apiService)
            }),
            ModulesFactory.makeBasketModule(
                basketInteractor: basketInteractor,
                showsNavigation: true,
                didSelectCheckout: { [weak self, weak tabbarController, weak apiService, weak basketInteractor] in
                    guard let self = self, let tabbarController = tabbarController, let apiService = apiService, let basketInteractor = basketInteractor else {
                        return
                    }
                    self.showCheckout(overViewController: tabbarController,
                                      apiService: apiService,
                                      basketInteractor: basketInteractor)
                }
            )
        ]

        window.rootViewController = tabbarController
        window.makeKeyAndVisible()

        showLogin(overViewController: tabbarController, apiService: apiService)

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

    private func makeProductsModule(apiService: APIService,
                                    basketInteractor: BasketInteractor) -> UIViewController {

        let productsInteractor = ProductsListInteractor(apiService: apiService)
        return ModulesFactory.makeProductsModule(productsInteractor: productsInteractor, basketInteractor: basketInteractor)
    }

    private func makeProfileModule(apiService: APIService, didPresLogout: @escaping () -> Void) -> UIViewController {
        let profileInteractor = ProfileInteractor(apiService: apiService)
        return ModulesFactory.makeProfileModule(profileInteractor: profileInteractor, didPresLogout: didPresLogout)
    }

    private func makeAddressesModule(apiService: APIService, addSelected: @escaping () -> Void) -> UIViewController {
        let addressesInteractor = AddressesListInteractor(apiService: apiService)
        return ModulesFactory.makeAddressesModule(addressesInteractor: addressesInteractor,
                                                  addSelected: addSelected)
    }
}

