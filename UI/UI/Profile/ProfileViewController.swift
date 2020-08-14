import UIKit
import Helpers

extension ProfileViewController: StoryboardInstantiatable {
    static var storyboardName: String { "Profile" }
}

final class ProfileViewController: UIViewController {
    struct Props {
        let currentUserEmail: String
        let didPressLogout: () -> Void
        let viewWillAppear: () -> Void

        static let defaultValue = Props(
            currentUserEmail: "",
            didPressLogout: {},
            viewWillAppear: {}
        )
    }

    @IBOutlet weak var emailLabel: UILabel!

    private var props = Props.defaultValue
    var retainedObject: AnyObject?

    func render(props: Props) {
        self.props = props
        if isViewLoaded {
            emailLabel.text = props.currentUserEmail
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        render(props: props)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        props.viewWillAppear()
    }

    @IBAction func didTouchLogout(_ sender: Any) {
        props.didPressLogout()
    }
}
