import UIKit.UIViewController
import TestScenario
@testable import UI

class DeliveryTimesScenario: TestScenario {
    override func buildViewController() -> UIViewController {
        let viewController = DeliveryTimesVC.instantiate()
        viewController.render(props: makeProps())
        return viewController
    }

    func makeProps() -> DeliveryTimesVC.Props {
        DeliveryTimesVC.Props(
            minDate: Date(),
            maxDate: Date().advanced(by: 7 * 24 * 3600),
            selectedDate: Date(),
            didSelectNewDate: { self.reportEventClosure(DescribeCalledFunction() + $0.debugDescription) }
        )
    }
}
