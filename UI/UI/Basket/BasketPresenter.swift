import Interactors

public final class BasketPresenter {
    typealias Props = BasketViewController.Props

    private weak var viewController: BasketViewController?
    private let interactor: BasketInteractor

    public init(viewController: BasketViewController, interactor: BasketInteractor) {
        self.viewController = viewController
        self.interactor = interactor
    }

    private func present() {
        let propsItems = interactor.basketData.items.map { apiItem -> Props.Item in
            Props.Item(
                imageURL: apiItem.product.imageUrl,
                title: apiItem.product.name,
                addedValue: "$\(apiItem.amountAdded * apiItem.product.price)",
                addedWeight: "\(apiItem.amountAdded) kg",
                didSelectDecrease: { [weak self] in self?.didSelectDecrease(forUUID: apiItem.product.id) },
                didSelectIncrease: { [weak self] in self?.didSelectIncrease(forUUID: apiItem.product.id) }
            )
        }

        viewController?.render(props: BasketViewController.Props(items: propsItems))
    }

    private func didSelectDecrease(forUUID uuid: UUID) {
        interactor.decrement(itemId: uuid)
        present()
    }

    private func didSelectIncrease(forUUID uuid: UUID) {
        interactor.decrement(itemId: uuid)
        present()
    }
}
