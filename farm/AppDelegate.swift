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
            ModulesFactory.makeBasketModule(basketInteractor: basketInteractor)
        ]

        window.rootViewController = tabbarController

        window.makeKeyAndVisible()

        return true
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

