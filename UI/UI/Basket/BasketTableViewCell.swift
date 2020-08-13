import UIKit
import Kingfisher

final class BasketTableViewCell: UITableViewCell {
    struct Item {
        let imageURL: URL
        let title: String
        let addedValue: String
        let addedWeight: String

        let didSelectDecrease: () -> Void
        let didSelectIncrease: () -> Void

        static let defaultValue = Item(
            imageURL: URL(string: "https://google.com")!,
            title: "",
            addedValue: "",
            addedWeight: "",
            didSelectDecrease: {},
            didSelectIncrease: {}
        )
    }

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addedValueLabel: UILabel!
    @IBOutlet weak var addedWeightLabel: UILabel!

    private var currentItem = Item.defaultValue

    func render(item: Item) {
        currentItem = item

        productImageView.kf.setImage(with: item.imageURL)
        titleLabel.text = item.title
        addedValueLabel.text = item.addedValue
        addedWeightLabel.text = item.addedWeight
    }

    @IBAction func decreaseAmountDidTouch(_ sender: Any) {
        currentItem.didSelectDecrease()
    }

    @IBAction func increaseAmountDidTouch(_ sender: Any) {
        currentItem.didSelectIncrease()
    }
}
