import UIKit
import Helpers

extension CheckoutSectionWrapperVC: StoryboardInstantiatable {
    static var storyboardName: String { "Checkout" }
}

final class CheckoutSectionWrapperVC: UIViewController {
    var headerTitle: String = "" {
        didSet {
            if isViewLoaded {
                titleLabel.text = headerTitle
            }
        }
    }

    var embeddedViewController: UIViewController = UIViewController() {
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

    override func viewDidLoad() {
        super.viewDidLoad()

        embed(viewController: embeddedViewController)
        titleLabel.text = headerTitle
    }

    private func embed(viewController: UIViewController) {
        self.addChild(embeddedViewController)
        containerView.embed(view: embeddedViewController.view)
        embeddedViewController.didMove(toParent: self)
    }
}
