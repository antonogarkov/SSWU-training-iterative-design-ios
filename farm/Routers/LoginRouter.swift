import UIKit
import Services
import Interactors
import UI

final class LoginRouter {
    private let apiService: APIService
    private let didFinish: () -> Void

    private var addAddressFlow: AddAddressFlow?

    init(apiService: APIService, didFinish: @escaping () -> Void) {
        self.apiService = apiService
        self.didFinish = didFinish
    }

    func start() -> UIViewController {
        let loginNavController = UINavigationController()
        loginNavController.setNavigationBarHidden(true, animated: false)

        let loginInteractor = LoginInteractor(apiService: apiService, didLogIn: { [weak self, weak loginNavController] in
            guard let self = self, let loginNavController = loginNavController else { return }

            let addAddressFlow = AddAddressFlow(
                embeddingNavController: loginNavController,
                apiService: self.apiService,
                didFinish: { [weak self] in
                    self?.didFinish()
                }
            )
            self.addAddressFlow = addAddressFlow
            addAddressFlow.start()
        })
        let loginModule = ModulesFactory.makeLoginModule(loginInteractor: loginInteractor)

        loginNavController.setViewControllers([loginModule], animated: false)

        return loginNavController
    }
}
