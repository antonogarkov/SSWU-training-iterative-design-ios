import UIKit.UIViewController
import TestScenario
@testable import UI

class BasketScenario: TestScenario {
    override func buildViewController() -> UIViewController {
        let viewController = BasketViewController.instantiate()

        viewController.render(props: makeProps())

        return viewController
    }

    func makeProps() -> BasketViewController.Props {
        BasketViewController.Props(
            items:
            [
                BasketViewController.Props.Item(
                    imageURL: URL(string: "https://i.pinimg.com/originals/da/a8/de/daa8de830c02a6d62bf3696faaae3d85.png")!,
                    title: "THICK FLANK",
                    addedValue: "$16.00",
                    addedWeight: "2 kg",
                    didSelectDecrease: { self.reportEventClosure(DescribeCalledFunction()) },
                    didSelectIncrease: { self.reportEventClosure(DescribeCalledFunction()) }
                ),
                BasketViewController.Props.Item(
                    imageURL: URL(string: "https://i.pinimg.com/originals/da/a8/de/daa8de830c02a6d62bf3696faaae3d85.png")!,
                    title: "RUMP",
                    addedValue: "$4.50",
                    addedWeight: "0.5 kg",
                    didSelectDecrease: { self.reportEventClosure(DescribeCalledFunction()) },
                    didSelectIncrease: { self.reportEventClosure(DescribeCalledFunction()) }
                ),
                BasketViewController.Props.Item(
                    imageURL: URL(string: "https://i.pinimg.com/originals/da/a8/de/daa8de830c02a6d62bf3696faaae3d85.png")!,
                    title: "SIRLOIN",
                    addedValue: "$4.00",
                    addedWeight: "0.25 kg",
                    didSelectDecrease: { self.reportEventClosure(DescribeCalledFunction()) },
                    didSelectIncrease: { self.reportEventClosure(DescribeCalledFunction()) }
                ),
            ],
            showsHeader: false,
            viewWillAppear: { self.reportEventClosure(DescribeCalledFunction()) }
        )
    }
}
