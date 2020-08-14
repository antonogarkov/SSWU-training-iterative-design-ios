import UIKit
import Helpers

private final class SectionView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setUp()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.setUp()
    }

    private func setUp() {
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
    }
}

extension CheckoutViewController: StoryboardInstantiatable {
    static var storyboardName: String { "Checkout" }
}

final class CheckoutViewController: UIViewController {
    struct Props {
        let didSelectPlaceOrder: () -> Void

        static let defaultValue = Props(didSelectPlaceOrder: {})
    }

    @IBOutlet private weak var generalStackView: UIStackView!

    private var sectionViews = [SectionView]()

    private var props = Props.defaultValue
    var retainedObject: AnyObject?

    var embeddedViewControllers: [UIViewController] = [] {
        willSet {
            embeddedViewControllers.forEach {
                $0.willMove(toParent: nil)
                $0.view.removeFromSuperview()
                $0.removeFromParent()
            }

            sectionViews.forEach { $0.removeFromSuperview() }
            sectionViews = []
        }

        didSet {
            if isViewLoaded {
                applyEmbeddedVCs(embeddedViewControllers: embeddedViewControllers)
            }
        }
    }

    func render(props: Props) {
        self.props = props
        if isViewLoaded {

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        applyEmbeddedVCs(embeddedViewControllers: embeddedViewControllers)

        render(props: props)
    }

    @IBAction func placeOrderButtonTouch(_ sender: Any) {
        props.didSelectPlaceOrder()
    }

    private func applyEmbeddedVCs(embeddedViewControllers: [UIViewController]) {
        embeddedViewControllers.forEach {
            self.addChild($0)

            let sectionView = SectionView()
            sectionView.embed(view: $0.view)
            sectionViews.append(sectionView)

            self.generalStackView.addArrangedSubview(sectionView)
            $0.didMove(toParent: self)
        }
    }
}
