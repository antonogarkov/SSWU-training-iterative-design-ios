import UIKit

public final class AddressListTableViewCell: UITableViewCell {
    struct Address {
        let zip: String
        let line1: String
        let line2: String
        let city: String
        let state: String
    }

    @IBOutlet weak var line1: UILabel!
    @IBOutlet weak var line2: UILabel!

    func render(address: Address) {
        line1.text = address.line2 + " " + address.line1
        line2.text = address.city + ", " + address.state + " " + address.zip
    }
}
