import UIKit
import SkyFloatingLabelTextField
import IQKeyboardManagerSwift
import Helpers

extension AddAddressViewController: StoryboardInstantiatable {
    static var storyboardName: String { "AddAddress" }
}

final class AddAddressViewController: UIViewController {
    struct Props {
        let addressLine1: String
        let addressLine2: String
        let city: String
        let state: String
        let zip: String

        let addAddressButtonTouch: () -> Void
        let didChangeAddressLine1: (String) -> Void
        let didChangeAddressLine2: (String) -> Void
        let didChangeCity: (String) -> Void
        let didChangeState: (String) -> Void
        let didChangeZip: (String) -> Void

        static let defaultValue = Props(
            addressLine1: "",
            addressLine2: "",
            city: "",
            state: "",
            zip: "",
            addAddressButtonTouch: {},
            didChangeAddressLine1: { _ in },
            didChangeAddressLine2: { _ in },
            didChangeCity: { _ in },
            didChangeState: { _ in },
            didChangeZip: { _ in }
        )
    }

    @IBOutlet private weak var lineOneTextField: SkyFloatingLabelTextField!
    @IBOutlet private weak var lineTwoTextField: SkyFloatingLabelTextField!
    @IBOutlet private weak var cityTextField: SkyFloatingLabelTextField!
    @IBOutlet private weak var stateTextField: SkyFloatingLabelTextField!
    @IBOutlet private weak var zipTextField: SkyFloatingLabelTextField!

    private var props = Props.defaultValue

    func render(props: Props) {
        self.props = props
        if isViewLoaded {
            lineOneTextField.text = props.addressLine1
            lineTwoTextField.text = props.addressLine2
            cityTextField.text = props.city
            stateTextField.text = props.state
            zipTextField.text = props.zip
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        IQKeyboardManager.shared.enable = true

        render(props: props)
    }

    @IBAction func didTouchAddAddressButton(_ sender: Any) {
        props.addAddressButtonTouch()
    }
}

extension AddAddressViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case lineOneTextField:
            props.didChangeAddressLine1(textField.text ?? "")
        case lineTwoTextField:
            props.didChangeAddressLine2(textField.text ?? "")
        case cityTextField:
            props.didChangeCity(textField.text ?? "")
        case stateTextField:
            props.didChangeState(textField.text ?? "")
        case zipTextField:
            props.didChangeZip(textField.text ?? "")
        default:
            break
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case lineOneTextField:
            lineTwoTextField.becomeFirstResponder()
        case lineTwoTextField:
            cityTextField.becomeFirstResponder()
        case cityTextField:
            stateTextField.becomeFirstResponder()
        case stateTextField:
            zipTextField.becomeFirstResponder()
        case zipTextField:
            self.view.endEditing(true)
        default:
            break
        }

        return true
    }
}
