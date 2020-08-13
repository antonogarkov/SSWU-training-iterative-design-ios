import UIKit
import Helpers

extension BasketViewController: StoryboardInstantiatable {
    static var storyboardName: String { "Basket" }
}

final class BasketViewController: UITableViewController {
    struct Props {
        typealias Item = BasketTableViewCell.Item

        let items: [Item]
        let showsHeader: Bool
        let viewWillAppear: () -> Void

        static let defaultValue = Props(items: [], showsHeader: false, viewWillAppear: {})
    }

    private var headerView: UIView?

    private var props = Props.defaultValue
    var retainedObject: AnyObject?

    func render(props: Props) {
        self.props = props
        if isViewLoaded {
            tableView.tableHeaderView = props.showsHeader ? headerView : nil

            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        headerView = tableView.tableHeaderView

        render(props: props)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        props.viewWillAppear()
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
