import UIKit
import Helpers

extension BasketViewController: StoryboardInstantiatable {
    static var storyboardName: String { "Basket" }
}

final class BasketViewController: UITableViewController {
    struct Props {
        typealias Item = BasketTableViewCell.Item

        let items: [Item]
        let showsHeaderAndFooter: Bool
        let viewWillAppear: () -> Void
        let didSelectCheckout: () -> Void

        static let defaultValue = Props(items: [], showsHeaderAndFooter: false, viewWillAppear: {}, didSelectCheckout: {})
    }

    private var headerView: UIView?
    private var footerView: UIView?

    private var props = Props.defaultValue
    var retainedObject: AnyObject?

    func render(props: Props) {
        self.props = props
        if isViewLoaded {
            tableView.tableHeaderView = props.showsHeaderAndFooter ? headerView : nil
            tableView.tableFooterView = props.showsHeaderAndFooter ? footerView : nil

            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        headerView = tableView.tableHeaderView
        footerView = tableView.tableFooterView

        render(props: props)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        props.viewWillAppear()
    }

    @IBAction func checkoutButtonTouch(_ sender: Any) {
        props.didSelectCheckout()
    }
}

// UITableViewDataSource
extension BasketViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        props.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketTableViewCell")

        if let itemCell = cell as? BasketTableViewCell {
            itemCell.render(item: props.items[indexPath.row])
        }

        return cell ?? UITableViewCell()
    }
}
