import UIKit
import Services
import Interactors
import UI

final class LoginRouter {
    private let apiService: APIService
    private let didFinish: () -> Void

    init(apiService: APIService, didFinish: @escaping () -> Void) {
        self.apiService = apiService
        self.didFinish = didFinish
    }

    func start() -> UIViewController {
        let loginNavController = UINavigationController()
        loginNavController.setNavigationBarHidden(true, animated: false)

        let loginInteractor = LoginInteractor(apiService: apiService, didLogIn: { [weak apiService, weak loginNavController] in
            guard let apiService = apiService, let loginNavController = loginNavController else { return }

            let addAddressInteractor = AddAddressInteractor(
                apiService: apiService,
                didAddAddress: { [weak loginNavController, weak self] in
                    guard let loginNavController = loginNavController else { return }

                    loginNavController.pushViewController(ModulesFactory.makeAddressAddedModule(), animated: true)

                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self?.didFinish()

                        //loginNavController.dismiss(animated: true, completion: nil)
                    }
                }
            )

            let module = ModulesFactory.makeAddAddressModule(addAddressInteractor: addAddressInteractor)
            loginNavController.pushViewController(module, animated: true)
        })
        let loginModule = ModulesFactory.makeLoginModule(loginInteractor: loginInteractor)

        loginNavController.setViewControllers([loginModule], animated: false)

        return loginNavController
    }
}
