import UIKit.UIViewController
import TestScenario
@testable import UI

class ProductsListScenario: TestScenario {
    override func buildViewController() -> UIViewController {
        let viewController = ProductsListViewController.instantiate()

        viewController.render(props: makeProps())

        return viewController
    }

    func makeProps() -> ProductsListViewController.Props {
        ProductsListViewController.Props(products: [
            ProductsListViewController.Props.Product(
                imageURL: URL(string: "https://i.pinimg.com/originals/da/a8/de/daa8de830c02a6d62bf3696faaae3d85.png")!,
                title: "THICK FLANK",
                description: "Thick flank beef - rear part",
                priceTag: "$8.00 per kg",
                addedAmount: "0 kg",
                didSelectIncrease: { self.reportEventClosure(DescribeCalledFunction()) },
                didSelectDecrease: { self.reportEventClosure(DescribeCalledFunction()) }
            ),
            ProductsListViewController.Props.Product(
                imageURL: URL(string: "https://i.pinimg.com/originals/da/a8/de/daa8de830c02a6d62bf3696faaae3d85.png")!,
                title: "RUMP",
                description: "Rump beef - rear back part",
                priceTag: "$9.00 per kg",
                addedAmount: "0 kg",
                didSelectIncrease: { self.reportEventClosure(DescribeCalledFunction()) },
                didSelectDecrease: { self.reportEventClosure(DescribeCalledFunction()) }
            ),
            ProductsListViewController.Props.Product(
                imageURL: URL(string: "https://i.pinimg.com/originals/da/a8/de/daa8de830c02a6d62bf3696faaae3d85.png")!,
                title: "SIRLOIN",
                description: "Sirloin beef - back part",
                priceTag: "$16.00 per kg",
                addedAmount: "0 kg",
                didSelectIncrease: { self.reportEventClosure(DescribeCalledFunction()) },
                didSelectDecrease: { self.reportEventClosure(DescribeCalledFunction()) }
            ),
            ProductsListViewController.Props.Product(
                imageURL: URL(string: "https://i.pinimg.com/originals/da/a8/de/daa8de830c02a6d62bf3696faaae3d85.png")!,
                title: "THICK RIB",
                description: "Thick rib - chest part",
                priceTag: "$4.00 per kg",
                addedAmount: "0 kg",
                didSelectIncrease: { self.reportEventClosure(DescribeCalledFunction()) },
                didSelectDecrease: { self.reportEventClosure(DescribeCalledFunction()) }
            )
        ])
    }
}
