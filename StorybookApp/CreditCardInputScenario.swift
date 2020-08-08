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
        CreditCardInputVC.Props()
    }
}
