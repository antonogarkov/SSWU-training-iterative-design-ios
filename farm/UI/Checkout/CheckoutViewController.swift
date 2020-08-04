import UIKit

private final class SectionView: UIView {
    private let separator: UIView = {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .lightGray

        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true

        return separator
    }()

    var isSepartorHidden: Bool {
        get {
            separator.isHidden
        }
        set {
            separator.isHidden = newValue
        }
    }

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

        addSubview(separator)
        NSLayoutConstraint.activate([
            separator.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            separator.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            separator.topAnchor.constraint(equalTo: topAnchor)
        ])
    }

    func embed(view: UIView) {
        self.addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            view.leftAnchor.constraint(equalTo: leftAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.rightAnchor.constraint(equalTo: rightAnchor),
            view.topAnchor.constraint(equalTo: topAnchor)
        ])

        bringSubviewToFront(separator)
    }
}

extension CheckoutViewController: StoryboardInstantiatable {
    static var storyboardName: String { "Checkout" }
}

public final class CheckoutViewController: UIViewController {
    struct Props {
        static let defaultValue = Props()
    }

    @IBOutlet private weak var generalStackView: UIStackView!

    private var sectionViews = [SectionView]()

    private var props = Props.defaultValue

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

    public override func viewDidLoad() {
        super.viewDidLoad()

        applyEmbeddedVCs(embeddedViewControllers: embeddedViewControllers)

        render(props: props)
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

        self.sectionViews.first?.isSepartorHidden = true
    }
}
