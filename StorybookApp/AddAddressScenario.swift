import UIKit.UIViewController
import TestScenario

class AddAddressScenario: TestScenario {
    override func buildViewController() -> UIViewController {
        let viewController = AddAddressViewController.instantiate()
        viewController.render(props: makeProps())
        return viewController
    }

    func makeProps() -> AddAddressViewController.Props {
        AddAddressViewController.Props(
            addressLine1: "",
            addressLine2: "",
            city: "",
            state: "",
            zip: "",
            addAddressButtonTouch: { self.reportEventClosure(DescribeCalledFunction()) },
            didChangeAddressLine1: { self.reportEventClosure(DescribeCalledFunction() + $0) },
            didChangeAddressLine2: { self.reportEventClosure(DescribeCalledFunction() + $0) },
            didChangeCity: { self.reportEventClosure(DescribeCalledFunction() + $0) },
            didChangeState: { self.reportEventClosure(DescribeCalledFunction() + $0) },
            didChangeZip: { self.reportEventClosure(DescribeCalledFunction() + $0) }
        )
    }
}
