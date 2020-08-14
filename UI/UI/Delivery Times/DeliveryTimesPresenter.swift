import Interactors

final class DeliveryTimesPresenter {
    typealias Props = DeliveryTimesVC.Props

    private weak var viewController: DeliveryTimesVC?
    private let checkoutInteractor: CheckoutInteractor

    init(viewController: DeliveryTimesVC, checkoutInteractor: CheckoutInteractor) {
        self.viewController = viewController
        self.checkoutInteractor = checkoutInteractor

        present()
    }

    private func present() {
        viewController?.render(props: Props(
            minDate: Date(),
            maxDate: Date().advanced(by: 7 * 24 * 3600),
            selectedDate: checkoutInteractor.date ?? Date(),
            didSelectNewDate: { [weak self] newDate in
                self?.checkoutInteractor.date = newDate
                self?.present()
            }
        ))
    }
}
