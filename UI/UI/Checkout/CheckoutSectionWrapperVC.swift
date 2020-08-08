import UIKit

extension CheckoutSectionWrapperVC: StoryboardInstantiatable {
    static var storyboardName: String { "Checkout" }
}

public final class CheckoutSectionWrapperVC: UIViewController {
    public var headerTitle: String = "" {
        didSet {
            if isViewLoaded {
                titleLabel.text = headerTitle
            }
        }
    }

    public var embeddedViewController: UIViewController = UIViewController() {
        willSet {
            embeddedViewController.willMove(toParent: nil)
            embeddedViewController.view.removeFromSuperview()
            embeddedViewController.removeFromParent()
        }

        didSet {
            if isViewLoaded {
                embed(viewController: embeddedViewController)
            }
        }
    }

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!

    public override func viewDidLoad() {
        super.viewDidLoad()

        embed(viewController: embeddedViewController)
        titleLabel.text = headerTitle
    }

    fileprivate func embed(viewController: UIViewController) {
        self.addChild(embeddedViewController)
        containerView.embed(view: embeddedViewController.view)
        embeddedViewController.didMove(toParent: self)
    }
}
