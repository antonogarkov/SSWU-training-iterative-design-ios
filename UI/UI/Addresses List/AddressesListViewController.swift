import UIKit

extension AddressesListViewController: StoryboardInstantiatable {
    public static var storyboardName: String { "AddressesList" }
}

public final class AddressesListViewController: UITableViewController {
    struct Props {
        typealias Address = AddressListTableViewCell.Address

        let addresses: [Address]

        static let defaultValue = Props(addresses: [])
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
extension AddressesListViewController {
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        props.addresses.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressListTableViewCell")

        if let addressCell = cell as? AddressListTableViewCell {
            addressCell.render(address: props.addresses[indexPath.row])
        }

        return cell ?? UITableViewCell()
    }
}
