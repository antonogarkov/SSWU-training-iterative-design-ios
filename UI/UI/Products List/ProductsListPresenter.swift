import Interactors

public final class ProductsListPresenter {
    typealias Props = ProductsListViewController.Props

    private let productsInteractor: ProductsListInteractor
    private let basketInteractor: BasketInteractor
    private weak var viewController: ProductsListViewController?

    public init(productsInteractor: ProductsListInteractor,
                basketInteractor: BasketInteractor,
                viewController: ProductsListViewController) {

        self.productsInteractor = productsInteractor
        self.basketInteractor = basketInteractor
        self.viewController = viewController

        productsInteractor.loadProducts()
        present()
    }

    private func present() {
        let propsProducts = productsInteractor.apiProducts.map { [weak self] apiProduct -> Props.Product in

            let basketProduct = basketInteractor.basketData.items.first { $0.product.id == apiProduct.id }

            return Props.Product(
                imageURL: apiProduct.imageUrl,
                title: apiProduct.name,
                description: apiProduct.description,
                priceTag: "$\(apiProduct.price) per 1 kg",
                addedAmount: "\(basketProduct?.amountAdded ?? 0) kg",
                didSelectIncrease: { [weak self] in
                    self?.didSelectIncrease(forUUID: apiProduct.id)
                },
                didSelectDecrease: { [weak self] in
                    self?.didSelectDecrease(forUUID: apiProduct.id)
                }
            )
        }

        let props = ProductsListViewController.Props(
            products: propsProducts,
            viewWillAppear: { [weak self] in
                self?.present()
            }
        )

        viewController?.render(props: props)
    }

    private func didSelectDecrease(forUUID uuid: UUID) {
        basketInteractor.decrement(itemId: uuid)
        present()
    }

    private func didSelectIncrease(forUUID uuid: UUID) {
        basketInteractor.increment(itemId: uuid)
        present()
    }
}
