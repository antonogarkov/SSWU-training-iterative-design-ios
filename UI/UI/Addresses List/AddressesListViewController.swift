import UIKit
import Helpers

extension AddressesListViewController: StoryboardInstantiatable {
    static var storyboardName: String { "AddressesList" }
}

final class AddressesListViewController: UITableViewController {
    struct Props {
        typealias Address = AddressListTableViewCell.Address

        let addresses: [Address]
        let showsHeader: Bool

        static let defaultValue = Props(addresses: [], showsHeader: true)
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
}

// UITableViewDataSource
extension AddressesListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        props.addresses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressListTableViewCell")

        if let addressCell = cell as? AddressListTableViewCell {
            addressCell.render(address: props.addresses[indexPath.row])
        }

        return cell ?? UITableViewCell()
    }
}
