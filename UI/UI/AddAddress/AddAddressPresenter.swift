import Interactors

final class AddAddressPresenter {
    typealias Props = AddAddressViewController.Props

    weak var viewController: AddAddressViewController?
    let interactor: AddAddressInteractor

    init(viewController: AddAddressViewController, interactor: AddAddressInteractor) {

        self.viewController = viewController
        self.interactor = interactor

        present()
    }

    private func present() {
        viewController?.render(props: Props(
            addressLine1: interactor.addressLine1,
            addressLine2: interactor.addressLine2,
            city: interactor.city,
            state: interactor.state,
            zip: interactor.zip,
            addAddressButtonTouch: { [weak self] in
                self?.interactor.submitForm()
            },
            didChangeAddressLine1: { [weak self] in
                self?.interactor.addressLine1 = $0
                self?.present()
            },
            didChangeAddressLine2: { [weak self] in
                self?.interactor.addressLine2 = $0
                self?.present()
            },
            didChangeCity: { [weak self] in
                self?.interactor.city = $0
                self?.present()
            },
            didChangeState: { [weak self] in
                self?.interactor.state = $0
                self?.present()
            },
            didChangeZip: { [weak self] in
                self?.interactor.zip = $0
                self?.present()
            }
        ))
    }
}
