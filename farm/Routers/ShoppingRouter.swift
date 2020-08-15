import UIKit
import Services
import Interactors
import UI

final class ShoppingRouter {
    private let tabbar = UITabBarController()
    private let basketInteractor: BasketInteractor
    private let apiService: APIService
    private let onShowLogin: () -> Void
    private let onShowCheckout: () -> Void

    init(basketInteractor: BasketInteractor,
         apiService: APIService,
         onShowLogin: @escaping () -> Void,
         onShowCheckout: @escaping () -> Void) {
        self.basketInteractor = basketInteractor
        self.apiService = apiService

        self.onShowLogin = onShowLogin
        self.onShowCheckout = onShowCheckout
    }

    func start() -> UIViewController {
        let addressesNavigationController = UINavigationController()
        addressesNavigationController.setNavigationBarHidden(true, animated: false)

        let addressesViewController = makeAddressesModule(
            apiService: apiService,
            addSelected: { [weak self] in
                guard let self = self else { return }

                let addAddressInteractor = AddAddressInteractor(
                    apiService: self.apiService,
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
            makeProfileModule(apiService: apiService, didPresLogout: { [weak self] in
                print("PANIC! I DON'T KNOW WHAT TO DO HERE!!")
                self?.apiService.resetSession()
                self?.onShowLogin()
            }),
            ModulesFactory.makeBasketModule(
                basketInteractor: basketInteractor,
                showsNavigation: true,
                didSelectCheckout: { [weak self] in
                    self?.onShowCheckout()
                }
            )
        ]

        return tabbarController
    }

    private func makeProductsModule(apiService: APIService,
                                    basketInteractor: BasketInteractor) -> UIViewController {

        let productsInteractor = ProductsListInteractor(apiService: apiService)
        return ModulesFactory.makeProductsModule(productsInteractor: productsInteractor, basketInteractor: basketInteractor)
    }

    private func makeAddressesModule(apiService: APIService, addSelected: @escaping () -> Void) -> UIViewController {
        let addressesInteractor = AddressesListInteractor(apiService: apiService)
        return ModulesFactory.makeAddressesModule(addressesInteractor: addressesInteractor,
                                                  addSelected: addSelected)
    }

    private func makeProfileModule(apiService: APIService, didPresLogout: @escaping () -> Void) -> UIViewController {
        let profileInteractor = ProfileInteractor(apiService: apiService)
        return ModulesFactory.makeProfileModule(profileInteractor: profileInteractor, didPresLogout: didPresLogout)
    }
}
