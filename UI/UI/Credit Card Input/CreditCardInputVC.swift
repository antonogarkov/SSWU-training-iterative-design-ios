import UIKit
import Stripe

extension CreditCardInputVC: StoryboardInstantiatable {
    static var storyboardName: String { "CreditCardInput" }
}

public final class CreditCardInputVC: UIViewController {
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

    public override func viewDidLoad() {
        super.viewDidLoad()

        textField.borderColor = UIColor(named: "BrandBlue")
        textField.font = UIFont(name: "AvenirNextCondensed-Regular", size: 17)
    }
}

extension CreditCardInputVC: STPPaymentCardTextFieldDelegate {
    public func paymentCardTextFieldDidEndEditingNumber(_ textField: STPPaymentCardTextField) {
        props.didEnterNumber(textField.cardNumber ?? "")
    }

    public func paymentCardTextFieldDidEndEditingCVC(_ textField: STPPaymentCardTextField) {
        props.didEnterCVC(textField.cvc ?? "")
    }

    public func paymentCardTextFieldDidEndEditingExpiration(_ textField: STPPaymentCardTextField) {
        props.didEnterExp("\(textField.expirationMonth)/\(textField.expirationYear)")
    }

    public func paymentCardTextFieldDidEndEditingPostalCode(_ textField: STPPaymentCardTextField) {
        props.didEnterPostalCode(textField.postalCode ?? "")
    }
}
