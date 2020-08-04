import UIKit.UIViewController
import TestScenario
@testable import UI

class LoginScenario: TestScenario {
    override func buildViewController() -> UIViewController {
        let viewController = LoginViewController.instantiate()
        viewController.render(props: makeProps())
        return viewController
    }

    func makeProps() -> LoginViewController.Props {
        LoginViewController.Props(mail: "",
                                  password: "",
                                  goButtonTouch: { self.reportEventClosure(DescribeCalledFunction()) },
                                  didChangeMail: { self.reportEventClosure(DescribeCalledFunction() + $0) },
                                  didChangePassword: { self.reportEventClosure(DescribeCalledFunction() + $0) })
    }
}
