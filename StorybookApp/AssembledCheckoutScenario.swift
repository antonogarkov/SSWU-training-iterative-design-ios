import UIKit.UIViewController
import TestScenario
@testable import UI

class AssembledCheckoutScenario: TestScenario {
    override func buildViewController() -> UIViewController {
        let viewController = CheckoutViewController.instantiate()

        let addressListVC = AddressesListScenario(reportEventClosure: reportEventClosure).buildViewController()
        let basketVC = BasketScenario(reportEventClosure: reportEventClosure).buildViewController()
        let creditCardInputVC = CreditCardInputScenario(reportEventClosure: reportEventClosure).buildViewController()

        let addressWrapper = CheckoutSectionWrapperVC.instantiate()
        addressWrapper.embeddedViewController = addressListVC
        addressWrapper.headerTitle = "SELECT DELIVERY ADDRESS"

        let creditCardWrapper = CheckoutSectionWrapperVC.instantiate()
        creditCardWrapper.embeddedViewController = creditCardInputVC
        creditCardWrapper.headerTitle = "SPECIFY YOUR PAYMENT CARD"

        let basketWrapper = CheckoutSectionWrapperVC.instantiate()
        basketWrapper.embeddedViewController = basketVC
        basketWrapper.headerTitle = "REVIEW YOUR ORDER"

        viewController.embeddedViewControllers = [
            addressWrapper,
            creditCardWrapper,
            basketWrapper
        ]

        viewController.render(props: makeProps())

        return viewController
    }

    func makeProps() -> CheckoutViewController.Props {
        CheckoutViewController.Props()
    }
}
