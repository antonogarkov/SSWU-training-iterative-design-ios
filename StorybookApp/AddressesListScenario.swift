import UIKit.UIViewController
import TestScenario
@testable import UI

class AddressesListScenario: TestScenario {
    override func buildViewController() -> UIViewController {
        let viewController = AddressesListViewController.instantiate()
        viewController.render(props: makeProps())
        return viewController
    }

    func makeProps() -> AddressesListViewController.Props {
        return AddressesListViewController.Props(
            addresses: [
                AddressesListViewController.Props.Address(
                    selectionState: nil,
                    zip: "95014",
                    line1: "Infinite Loop",
                    line2: "1",
                    city: "Cupertino",
                    state: "CA"
                ),
                AddressesListViewController.Props.Address(
                    selectionState: nil,
                    zip: "11218",
                    line1: "Avenue F",
                    line2: "420",
                    city: "Brooklyn",
                    state: "NY"
                ),
                AddressesListViewController.Props.Address(
                    selectionState: nil,
                    zip: "50315",
                    line1: "E Wall Ave",
                    line2: "443",
                    city: "Des Moines",
                    state: "IA"
                ),
                AddressesListViewController.Props.Address(
                    selectionState: AddressesListViewController.Props.Address.SelectionState(
                        didSelect: { self.reportEventClosure(DescribeCalledFunction()) },
                        isSelected: false
                    ),
                    zip: "84634",
                    line1: "N 100 W",
                    line2: "52",
                    city: "Gunnison",
                    state: "UT"
                ),
                AddressesListViewController.Props.Address(
                    selectionState: AddressesListViewController.Props.Address.SelectionState(
                        didSelect: { self.reportEventClosure(DescribeCalledFunction()) },
                        isSelected: true
                    ),
                    zip: "95014",
                    line1: "Infinite Loop",
                    line2: "1",
                    city: "Cupertino",
                    state: "CA"
                )
            ],
            viewWillAppear: { self.reportEventClosure(DescribeCalledFunction()) },
            showsHeader: false
        )
    }
}
