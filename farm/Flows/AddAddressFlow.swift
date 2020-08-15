import UIKit
import Interactors
import Services
import UI

final class AddAddressFlow {
    private let embeddingNavController: UINavigationController
    private let apiService: APIService
    private let didFinish: () -> Void

    init(embeddingNavController: UINavigationController, apiService: APIService, didFinish: @escaping () -> Void) {
        self.embeddingNavController = embeddingNavController
        self.apiService = apiService
        self.didFinish = didFinish
    }

    func start() {
        let addAddressInteractor = AddAddressInteractor(
            apiService: self.apiService,
            didAddAddress: { [weak embeddingNavController, weak self] in
                guard let embeddingNavController = embeddingNavController else { return }

                embeddingNavController.pushViewController(ModulesFactory.makeAddressAddedModule(), animated: true)

                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self?.didFinish()
                }
            }
        )

        let module = ModulesFactory.makeAddAddressModule(addAddressInteractor: addAddressInteractor)
        embeddingNavController.pushViewController(module, animated: true)
    }
}
