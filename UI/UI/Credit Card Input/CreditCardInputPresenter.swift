import Interactors

final class CreditCardInputPresenter {
    typealias Props = CreditCardInputVC.Props

    private weak var viewController: CreditCardInputVC?
    private let interactor: CheckoutInteractor

    init(viewController: CreditCardInputVC, interactor: CheckoutInteractor) {
        self.viewController = viewController
        self.interactor = interactor

        present()
    }

    private func present() {
        viewController?.render(props: Props(
            didEnterNumber: { [weak self] in self?.interactor.cardNumber = $0 },
            didEnterCVC: { [weak self] in self?.interactor.cardCVC = $0 },
            didEnterExp: { [weak self] in self?.interactor.cardExp = $0 },
            didEnterPostalCode: { [weak self] in self?.interactor.cardPostalCode = $0 }
        ))
    }
}
