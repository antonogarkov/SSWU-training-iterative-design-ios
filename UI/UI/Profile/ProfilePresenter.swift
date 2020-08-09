import Interactors

public final class ProfilePresenter {
    private weak var viewController: ProfileViewController?
    private let interactor: ProfileInteractor

    public init(viewController: ProfileViewController, interactor: ProfileInteractor) {

        self.viewController = viewController
        self.interactor = interactor

        interactor.loadCurrentUserEmail()
        present()
    }

    private func present() {
        viewController?.render(props: ProfileViewController.Props(
            currentUserEmail: interactor.userEmail ?? "",
            didPressLogout: {}
        ))
    }
}
