import UIKit
import TestScenarioUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let mainWindow = UIWindow(frame: UIScreen.main.bounds)

        ConfigureTestApplication(withConfig: TestApplicationManagerConfig(scenariosClasses: [LoginScenario.self, AddAddressScenario.self, ProductsListScenario.self, AddressesListScenario.self]))

        mainWindow.rootViewController = ScenarioTestingRootViewController()

        mainWindow.makeKeyAndVisible()

        window = mainWindow

        return true
    }
}
