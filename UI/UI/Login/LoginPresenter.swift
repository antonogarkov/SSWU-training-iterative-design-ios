import Interactors

final class LoginPresenter {
    typealias Props = LoginViewController.Props

    private weak var viewController: LoginViewController?
    private let interactor: LoginInteractor

    init(viewController: LoginViewController, interactor: LoginInteractor) {
        self.viewController = viewController
        self.interactor = interactor

        present()
    }

    private func present() {
        viewController?.render(props:
            LoginViewController.Props(
                mail: interactor.mail,
                password: interactor.password,
                goButtonTouch: { [weak self] in
                    self?.interactor.submit()
                    self?.present()
                },
                didChangeMail: { [weak self] in
                    self?.interactor.mail = $0
                    self?.present()
                },
                didChangePassword: { [weak self] in
                    self?.interactor.password = $0
                }
            )
        )
    }
}
