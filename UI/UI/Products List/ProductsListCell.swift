import UIKit
import Kingfisher

final class ProductsListCell: UITableViewCell {
    struct Product {
        let imageURL: URL
        let title: String
        let description: String
        let priceTag: String
        let addedAmount: String

        let didSelectIncrease: () -> Void
        let didSelectDecrease: () -> Void

        static let defaultValue = Product(
            imageURL: URL(string: "http://google.com")!,
            title: "",
            description: "",
            priceTag: "",
            addedAmount: "",
            didSelectIncrease: {},
            didSelectDecrease: {}
        )
    }

    private var currentProduct = Product.defaultValue

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var pricetagLabel: UILabel!
    @IBOutlet weak var addedAmountLabel: UILabel!

    func render(product: Product) {
        currentProduct = product

        productImageView.kf.setImage(with: product.imageURL)
        productTitleLabel.text = product.title
        productDescriptionLabel.text = product.description
        pricetagLabel.text = product.priceTag
        addedAmountLabel.text = product.addedAmount
    }

    @IBAction func didPressDecreaseButton(_ sender: Any) {
        currentProduct.didSelectDecrease()
    }

    @IBAction func didPressIncreaseBurron(_ sender: Any) {
        currentProduct.didSelectIncrease()
    }
}
