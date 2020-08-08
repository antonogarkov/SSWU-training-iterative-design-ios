import UIKit

extension UIView {
    func embed(view: UIView) {
        self.addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            view.leftAnchor.constraint(equalTo: leftAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.rightAnchor.constraint(equalTo: rightAnchor),
            view.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
}
