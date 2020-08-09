import Interactors

public final class BasketPresenter {
    typealias Props = BasketViewController.Props

    private weak var viewController: BasketViewController?
    private let interactor: BasketInteractor

    public init(viewController: BasketViewController, interactor: BasketInteractor) {
        self.viewController = viewController
        self.interactor = interactor

        interactor.reloadBasket()
        present()
    }

    private func present() {
        let propsItems = interactor.basketData.items.map { apiItem -> Props.Item in
            Props.Item(
                imageURL: apiItem.product.imageUrl,
                title: apiItem.product.name,
                addedValue: "$\(String(format: "%.2f", apiItem.amountAdded * apiItem.product.price))",
                addedWeight: "\(String(format: "%.2f", apiItem.amountAdded)) kg",
                didSelectDecrease: { [weak self] in
                    self?.didSelectDecrease(forUUID: apiItem.product.id)
                },
                didSelectIncrease: { [weak self] in
                    self?.didSelectIncrease(forUUID: apiItem.product.id)
                }
            )
        }



        let props = BasketViewController.Props(
            items: propsItems,
            viewWillAppear: { [weak self] in
                self?.present()
            }
        )

        viewController?.render(props: props)
    }

    private func didSelectDecrease(forUUID uuid: UUID) {
        interactor.decrement(itemId: uuid)
        present()
    }

    private func didSelectIncrease(forUUID uuid: UUID) {
        interactor.increment(itemId: uuid)
        present()
    }
}
