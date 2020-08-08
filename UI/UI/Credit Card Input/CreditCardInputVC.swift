import UIKit
import Stripe

extension CreditCardInputVC: StoryboardInstantiatable {
    static var storyboardName: String { "CreditCardInput" }
}

public final class CreditCardInputVC: UIViewController {
    struct Props {
        static let defaultValue = Props()
    }

    private var props = Props.defaultValue
    @IBOutlet weak var textField: STPPaymentCardTextField!

    func render(props: Props) {
        self.props = props
        if isViewLoaded {

        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        textField.borderColor = UIColor(named: "BrandBlue")
        textField.font = UIFont(name: "AvenirNextCondensed-Regular", size: 17)

        render(props: props)
    }
}
