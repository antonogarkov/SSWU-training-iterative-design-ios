import UIKit

extension ProfileViewController: StoryboardInstantiatable {
    static var storyboardName: String { "Profile" }
}

public final class ProfileViewController: UIViewController {
    struct Props {
        let currentUserEmail: String
        let didPressLogout: () -> Void

        static let defaultValue = Props(
            currentUserEmail: "",
            didPressLogout: {}
        )
    }

    @IBOutlet weak var emailLabel: UILabel!

    private var props = Props.defaultValue

    func render(props: Props) {
        self.props = props
        if isViewLoaded {
            emailLabel.text = props.currentUserEmail
        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        render(props: props)
    }

    @IBAction func didTouchLogout(_ sender: Any) {
        props.didPressLogout()
    }
}
