import UIKit
import TestScenarioUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let mainWindow = UIWindow(frame: UIScreen.main.bounds)

        ConfigureTestApplication(withConfig: TestApplicationManagerConfig(scenariosClasses: []))

        mainWindow.rootViewController = ScenarioTestingRootViewController()

        mainWindow.makeKeyAndVisible()

        return true
    }
}
