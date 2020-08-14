import Interactors

final class BasketPresenter {
    typealias Props = BasketViewController.Props

    private weak var viewController: BasketViewController?
    private let interactor: BasketInteractor
    private let didSelectCheckout: () -> Void

    init(viewController: BasketViewController, interactor: BasketInteractor, didSelectCheckout: @escaping () -> Void) {
        self.viewController = viewController
        self.interactor = interactor
        self.didSelectCheckout = didSelectCheckout

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
            showsHeaderAndFooter: true,
            viewWillAppear: { [weak self] in
                self?.present()
            },
            didSelectCheckout: didSelectCheckout
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
