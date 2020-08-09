import Services

public final class BasketInteractor {
    private let apiService: APIService

    public private(set) var basketData = APIService.Basket.empty

    public init(apiService: APIService) {
        self.apiService = apiService

        reloadBasket()
    }

    public func reloadBasket() {
        basketData = apiService.getBasket()
    }

    public func increment(itemId: UUID) {
        basketData = apiService.incrementProductInBasket(uuid: itemId)
    }

    public func decrement(itemId: UUID) {
        basketData = apiService.decrementProductInBasket(uuid: itemId)
    }
}
