import UIKit.UIViewController
import TestScenario
@testable import UI

class CreditCardInputScenario: TestScenario {
    override func buildViewController() -> UIViewController {
        let viewController = CreditCardInputVC.instantiate()
        viewController.render(props: makeProps())
        return viewController
    }

    func makeProps() -> CreditCardInputVC.Props {
        CreditCardInputVC.Props(
            didEnterNumber: { self.reportEventClosure(DescribeCalledFunction() + $0) },
            didEnterCVC: { self.reportEventClosure(DescribeCalledFunction() + $0) },
            didEnterExp: { self.reportEventClosure(DescribeCalledFunction() + $0) },
            didEnterPostalCode: { self.reportEventClosure(DescribeCalledFunction() + $0) }
        )
    }
}
