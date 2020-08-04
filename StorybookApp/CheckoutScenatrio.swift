import UIKit.UIViewController
import TestScenario

fileprivate class ColoredViewController: UIViewController {
    var color = UIColor.clear

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = color
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
}

class CheckoutScenario: TestScenario {
    override func buildViewController() -> UIViewController {
        let viewController = CheckoutViewController.instantiate()

        viewController.render(props: makeProps())

        let rainbow: [UIColor] = [
            .red,
            .orange,
            .yellow,
            .green,
            .init(red: 173.0 / 255, green: 216.0 / 255, blue: 230.0 / 255, alpha: 1),
            .blue,
            .init(red: 187.0 / 255, green: 173.0 / 255, blue: 230.0 / 255, alpha: 1),
        ]

        viewController.embeddedViewControllers = rainbow.map {
            let vc = ColoredViewController()
            vc.color = $0
            return vc
        }

        return viewController
    }

    func makeProps() -> CheckoutViewController.Props {
        CheckoutViewController.Props()
    }
}
