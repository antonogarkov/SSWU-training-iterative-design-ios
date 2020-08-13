import Interactors

final class AddressesListPresenter {
    typealias Props = AddressesListViewController.Props

    private weak var viewController: AddressesListViewController?
    private let interactor: AddressesListInteractor

    init(viewController: AddressesListViewController, interactor: AddressesListInteractor) {
        self.viewController = viewController
        self.interactor = interactor

        interactor.loadAddresses()
        present()
    }

    private func present() {
        let propsAddresses = interactor.addresses.map { apiAddress -> Props.Address in
            Props.Address(
                zip: apiAddress.zip,
                line1: apiAddress.addressFirstLine,
                line2: apiAddress.addressSecondLine,
                city: apiAddress.city,
                state: apiAddress.state
            )
        }

        viewController?.render(props: Props(addresses: propsAddresses, showsHeader: true))
    }
}
