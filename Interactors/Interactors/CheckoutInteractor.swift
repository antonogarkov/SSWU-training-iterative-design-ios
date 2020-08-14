import Services

public final class CheckoutInteractor {
    private let apiService: APIService
    private let didSubmitOrder: () -> Void

    public init(apiService: APIService,
                didSubmitOrder: @escaping () -> Void) {
        self.apiService = apiService
        self.didSubmitOrder = didSubmitOrder
    }

    public func submitOrder() {
        let didSucceed = apiService.submitOrder()
        if didSucceed {
            didSubmitOrder()
        }
    }
}
