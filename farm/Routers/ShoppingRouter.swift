import UIKit
import Services
import Interactors
import UI

final class ShoppingRouter {
    private let basketInteractor: BasketInteractor
    private let apiService: APIService
    private let onShowLogin: () -> Void
    private let onShowCheckout: () -> Void
    private let onLogout: () -> Void

    private var addAddressFlow: AddAddressFlow?

    init(basketInteractor: BasketInteractor,
         apiService: APIService,
         onShowLogin: @escaping () -> Void,
         onLogout: @escaping () -> Void,
         onShowCheckout: @escaping () -> Void) {
        self.basketInteractor = basketInteractor
        self.apiService = apiService

        self.onShowLogin = onShowLogin
        self.onShowCheckout = onShowCheckout
        self.onLogout = onLogout
    }

    func start() -> UIViewController {
        let addressesNavigationController = UINavigationController()
        addressesNavigationController.setNavigationBarHidden(true, animated: false)

        let addressesViewController = makeAddressesModule(
            apiService: apiService,
            addSelected: { [weak self, weak addressesNavigationController] in
                guard let self = self, let addressesNavigationController = addressesNavigationController else { return }

                let addAddressFlow = AddAddressFlow(
                    embeddingNavController: addressesNavigationController,
                    apiService: self.apiService,
                    didFinish: { [weak addressesNavigationController] in
                        addressesNavigationController?.popToRootViewController(animated: true)
                    }
                )
                self.addAddressFlow = addAddressFlow
                addAddressFlow.start()
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

                self?.onLogout()
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
