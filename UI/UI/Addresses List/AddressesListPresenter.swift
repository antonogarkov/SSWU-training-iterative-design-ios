import Interactors

final class AddressesListPresenter {
    typealias Props = AddressesListViewController.Props

    private weak var viewController: AddressesListViewController?
    private let interactor: AddressesListInteractor
    private let addSelected: () -> Void

    init(viewController: AddressesListViewController, interactor: AddressesListInteractor, addSelected: @escaping () -> Void) {
        self.viewController = viewController
        self.interactor = interactor
        self.addSelected = addSelected

        interactor.loadAddresses()
        present()
    }

    private func present() {
        let propsAddresses = interactor.addresses.map { apiAddress -> Props.Address in
            Props.Address(
                selectionState: nil,
                zip: apiAddress.zip,
                line1: apiAddress.addressFirstLine,
                line2: apiAddress.addressSecondLine,
                city: apiAddress.city,
                state: apiAddress.state
            )
        }

        viewController?.render(props: Props(
            addresses: propsAddresses,
            viewWillAppear: { [weak self] in
                self?.interactor.loadAddresses()
                self?.present()
            },
            addSelected: addSelected,
            showsHeader: true
        ))
    }
}
