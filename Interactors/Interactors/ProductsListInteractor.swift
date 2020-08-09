import Services

public final class ProductsListInteractor {
    private let apiService: APIService
    public private(set) var apiProducts: [APIService.Product] = []

    public init(apiService: APIService) {
        self.apiService = apiService
    }

    public func loadProducts() {
        apiProducts = apiService.getProducts()
    }
}
