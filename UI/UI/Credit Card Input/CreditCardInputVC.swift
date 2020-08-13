import UIKit
import Stripe
import Helpers

extension CreditCardInputVC: StoryboardInstantiatable {
    static var storyboardName: String { "CreditCardInput" }
}

final class CreditCardInputVC: UIViewController {
    struct Props {
        let didEnterNumber: (String) -> Void
        let didEnterCVC: (String) -> Void
        let didEnterExp: (String) -> Void
        let didEnterPostalCode: (String) -> Void

        static let defaultValue = Props(
            didEnterNumber: { _ in },
            didEnterCVC: { _ in },
            didEnterExp: { _ in },
            didEnterPostalCode: { _ in }
        )
    }

    private var props = Props.defaultValue
    @IBOutlet weak var textField: STPPaymentCardTextField!

    func render(props: Props) {
        self.props = props
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        textField.borderColor = UIColor(named: "BrandBlue", in: Bundle(for: RoundedBlueButton.self), compatibleWith: nil)
        textField.font = UIFont(name: "AvenirNextCondensed-Regular", size: 17)
    }
}

extension CreditCardInputVC: STPPaymentCardTextFieldDelegate {
    func paymentCardTextFieldDidEndEditingNumber(_ textField: STPPaymentCardTextField) {
        props.didEnterNumber(textField.cardNumber ?? "")
    }

    func paymentCardTextFieldDidEndEditingCVC(_ textField: STPPaymentCardTextField) {
        props.didEnterCVC(textField.cvc ?? "")
    }

    func paymentCardTextFieldDidEndEditingExpiration(_ textField: STPPaymentCardTextField) {
        props.didEnterExp("\(textField.expirationMonth)/\(textField.expirationYear)")
    }

    func paymentCardTextFieldDidEndEditingPostalCode(_ textField: STPPaymentCardTextField) {
        props.didEnterPostalCode(textField.postalCode ?? "")
    }
}
