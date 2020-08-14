import Interactors
//import Services

final class AddressesListCheckoutPresenter {
    typealias Props = AddressesListViewController.Props

    private weak var viewController: AddressesListViewController?
    private let addressesListInteractor: AddressesListInteractor
    private let checkoutInteractor: CheckoutInteractor

    init(viewController: AddressesListViewController,
         addressesListInteractor: AddressesListInteractor,
         checkoutInteractor: CheckoutInteractor) {

        self.viewController = viewController
        self.addressesListInteractor = addressesListInteractor
        self.checkoutInteractor = checkoutInteractor

        addressesListInteractor.loadAddresses()
        present()
    }

    private func present() {
        let propsAddresses = addressesListInteractor.addresses.map { apiAddress -> Props.Address in
            let isSelected = (apiAddress.id == checkoutInteractor.selectedAddressId)
            let selectionState = Props.Address.SelectionState(
                didSelect: { [weak self] in
                    self?.checkoutInteractor.selectedAddressId = apiAddress.id
                    self?.present()
                },
                isSelected: isSelected
            )

            return Props.Address(
                selectionState: selectionState,
                zip: apiAddress.zip,
                line1: apiAddress.addressFirstLine,
                line2: apiAddress.addressSecondLine,
                city: apiAddress.city,
                state: apiAddress.state
            )
        }

        self.viewController?.render(props: Props(
            addresses: propsAddresses,
            viewWillAppear: {},
            addSelected: {},
            showsHeader: false
        ))
    }
}
