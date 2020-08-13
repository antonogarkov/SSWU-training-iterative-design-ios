import UIKit.UIButton

public final class RoundedBlueButton: UIButton {
    public override func awakeFromNib() {
        super.awakeFromNib()

        let brandBlue = UIColor(named: "BrandBlue", in: Bundle(for: RoundedBlueButton.self), compatibleWith: nil)

        layer.borderColor = brandBlue?.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 22

        setTitleColor(brandBlue, for: .normal)
    }
}

