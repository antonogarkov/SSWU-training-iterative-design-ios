import Services

public final class CheckoutInteractor {
    private let apiService: APIService
    private let didSubmitOrder: () -> Void

    public var selectedAddressId: UUID?
    public var date: Date?

    public var cardNumber: String?
    public var cardCVC: String?
    public var cardExp: String?
    public var cardPostalCode: String?

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
