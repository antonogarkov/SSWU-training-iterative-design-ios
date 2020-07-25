import UIKit.UIViewController
import TestScenario

class LoginScenario: TestScenario {
    override func buildViewController() -> UIViewController {
        return LoginViewController.instantiate()
    }
}
