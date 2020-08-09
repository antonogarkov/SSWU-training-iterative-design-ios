import UIKit

extension BasketViewController: StoryboardInstantiatable {
    public static var storyboardName: String { "Basket" }
}

public final class BasketViewController: UITableViewController {
    struct Props {
        typealias Item = BasketTableViewCell.Item

        let items: [Item]

        static let defaultValue = Props(items: [])
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
extension BasketViewController {
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        props.items.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketTableViewCell")

        if let itemCell = cell as? BasketTableViewCell {
            itemCell.render(item: props.items[indexPath.row])
        }

        return cell ?? UITableViewCell()
    }
}
