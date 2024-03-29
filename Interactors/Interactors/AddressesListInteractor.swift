import Services

public final class AddressesListInteractor {
    private let apiService: APIService

    public private(set) var addresses: [APIService.Address] = []

    public init(apiService: APIService) {
        self.apiService = apiService
    }

    public func loadAddresses() {
        addresses = apiService.getAddresses()
    }
}
