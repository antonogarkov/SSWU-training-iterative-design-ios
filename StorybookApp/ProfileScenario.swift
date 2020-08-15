import UIKit.UIViewController
import TestScenario
@testable import UI

class ProfileScenario: TestScenario {
    override func buildViewController() -> UIViewController {
        let viewController = ProfileViewController.instantiate()
        viewController.render(props: makeProps())
        return viewController
    }

    func makeProps() -> ProfileViewController.Props {
        ProfileViewController.Props(
            currentUserEmail: "mega_zayats100500@gmail.com",
            didPressLogout: { self.reportEventClosure(DescribeCalledFunction()) },
            viewWillAppear: { self.reportEventClosure(DescribeCalledFunction()) }
        )
    }
}
