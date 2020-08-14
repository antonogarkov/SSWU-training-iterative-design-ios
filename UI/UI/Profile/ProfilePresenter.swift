import Interactors

final class ProfilePresenter {
    private weak var viewController: ProfileViewController?
    private let interactor: ProfileInteractor
    private let didPresLogout: () -> Void

    init(viewController: ProfileViewController, interactor: ProfileInteractor, didPresLogout: @escaping () -> Void) {

        self.viewController = viewController
        self.interactor = interactor
        self.didPresLogout = didPresLogout

        interactor.loadCurrentUserEmail()
        present()
    }

    private func present() {
        viewController?.render(props: ProfileViewController.Props(
            currentUserEmail: interactor.userEmail ?? "",
            didPressLogout: didPresLogout,
            viewWillAppear: { [weak self] in
                self?.interactor.loadCurrentUserEmail()
                self?.present()
            }
        ))
    }
}
