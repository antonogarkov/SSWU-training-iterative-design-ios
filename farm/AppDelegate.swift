import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let window = UIWindow(frame: UIScreen.main.bounds)
    var application: Application?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window.makeKeyAndVisible()

        resetApplication()

        return true
    }

    private func resetApplication() {
        self.application = Application(window: window, resetCallback: { [weak self] in
            self?.resetApplication()
        })

        self.application?.start()
    }
}

