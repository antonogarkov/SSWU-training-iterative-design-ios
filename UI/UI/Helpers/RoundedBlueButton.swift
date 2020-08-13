import UIKit.UIButton

final class RoundedBlueButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()

        let brandBlue = UIColor(named: "BrandBlue", in: Bundle(for: RoundedBlueButton.self), compatibleWith: nil)

        layer.borderColor = brandBlue?.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 22

        setTitleColor(brandBlue, for: .normal)
    }
}

