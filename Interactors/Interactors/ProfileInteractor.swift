import Services

public final class ProfileInteractor {
    private let apiService: APIService

    public private(set) var userEmail: String?

    public init(apiService: APIService) {
        self.apiService = apiService
    }

    public func loadCurrentUserEmail() {
        userEmail = apiService.getProfileEmail()
    }
}
