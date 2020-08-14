import Interactors

final class CheckoutPresenter {
    typealias Props = CheckoutViewController.Props

    private weak var viewController: CheckoutViewController?
    private let interactor: CheckoutInteractor

    init(viewController: CheckoutViewController, interactor: CheckoutInteractor) {
        self.viewController = viewController
        self.interactor = interactor

        present()
    }

    private func present() {
        viewController?.render(props: Props(
            didSelectPlaceOrder: { [weak self] in
                self?.interactor.submitOrder()
            }
        ))
    }
}
