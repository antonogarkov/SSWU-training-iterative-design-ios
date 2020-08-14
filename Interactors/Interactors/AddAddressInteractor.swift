import Services

public final class AddAddressInteractor {
    private let apiService: APIService
    private let didAddAddress: () -> Void

    public var addressLine1 = ""
    public var addressLine2 = ""
    public var city = ""
    public var state = ""
    public var zip = ""

    public init(apiService: APIService, didAddAddress: @escaping () -> Void) {
        self.apiService = apiService
        self.didAddAddress = didAddAddress
    }

    public func submitForm() {
        guard !addressLine1.isEmpty
            && !addressLine2.isEmpty
            && !city.isEmpty
            && !state.isEmpty
            && !zip.isEmpty
            else {
                return
        }

        apiService.postAddress(addressFirstLine: addressLine1,
                               addressSecondLine: addressLine2,
                               city: city,
                               state: state,
                               zip: zip)

        didAddAddress()
    }
}
