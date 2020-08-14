import UIKit
import SkyFloatingLabelTextField
import IQKeyboardManagerSwift
import Helpers

extension LoginViewController: StoryboardInstantiatable {
    static var storyboardName: String { "Login" }
}

final class LoginViewController: UIViewController {
    struct Props {
        let mail: String
        let password: String

        let goButtonTouch: () -> Void
        let didChangeMail: (String) -> Void
        let didChangePassword: (String) -> Void

        static let defaultValue = Props(
            mail: "",
            password: "",
            goButtonTouch: {},
            didChangeMail: { _ in },
            didChangePassword: { _ in }
        )
    }

    private var props = Props.defaultValue
    var retainedObject: AnyObject?

    @IBOutlet private weak var mailTextField: SkyFloatingLabelTextField!
    @IBOutlet private weak var passwordTextField: SkyFloatingLabelTextField!

    func render(props: Props) {
        self.props = props
        if isViewLoaded {
            mailTextField.text = props.mail
            passwordTextField.text = props.password
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        IQKeyboardManager.shared.enable = true

        render(props: props)
    }

    @IBAction func didTouchGoButton(_ sender: Any) {
        props.goButtonTouch()
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case mailTextField:
            props.didChangeMail(textField.text ?? "")
        case passwordTextField:
            props.didChangePassword(textField.text ?? "")
        default:
            break
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case mailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            self.view.endEditing(true)
        default:
            break
        }

        return true
    }
}
