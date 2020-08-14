import Services

public final class LoginInteractor {
    private let apiService: APIService
    private let didLogIn: () -> Void

    public var mail = ""
    public var password = ""

    public init(apiService: APIService, didLogIn: @escaping () -> Void) {
        self.apiService = apiService
        self.didLogIn = didLogIn
    }

    public func submit() {
        guard !mail.isEmpty && !password.isEmpty else {
            return
        }
        let didLoginSuccessfully = apiService.login(email: mail, password: password)
        if didLoginSuccessfully {
            didLogIn()
        }
    }
}
