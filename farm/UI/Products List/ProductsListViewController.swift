import UIKit

extension ProductsListViewController: StoryboardInstantiatable {
    static var storyboardName: String { "ProductsList" }
}

public final class ProductsListViewController: UITableViewController {
    struct Props {
        typealias Product = ProductsListCell.Product

        let products: [Product]

        static let defaultValue = Props(products: [])
    }

    private var props = Props.defaultValue

    func render(props: Props) {
        self.props = props
        if isViewLoaded {
            tableView.reloadData()
        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        render(props: props)
    }
}

// UITableViewDataSource
extension ProductsListViewController {
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        props.products.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsListCell")

        if let productCell = cell as? ProductsListCell {
            productCell.render(product: props.products[indexPath.row])
        }

        return cell ?? UITableViewCell()
    }
}
