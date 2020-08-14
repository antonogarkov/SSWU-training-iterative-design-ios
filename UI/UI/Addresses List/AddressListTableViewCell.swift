import UIKit

final class AddressListTableViewCell: UITableViewCell {
    struct Address {
        let selectionState: SelectionState?; struct SelectionState {
            let didSelect: () -> Void
            let isSelected: Bool
        }

        let zip: String
        let line1: String
        let line2: String
        let city: String
        let state: String
    }

    @IBOutlet weak var line1: UILabel!
    @IBOutlet weak var line2: UILabel!
    @IBOutlet weak var selectionButton: UIButton!

    private var address: Address?

    func render(address: Address) {
        self.address = address

        line1.text = address.line2 + " " + address.line1
        line2.text = address.city + ", " + address.state + " " + address.zip

        if let selectionState = address.selectionState {
            let buttonImage = selectionState.isSelected ? UIImage(systemName: "circle.fill") : UIImage(systemName: "circle")
            selectionButton.setImage(buttonImage, for: .normal)

            selectionButton.isHidden = false
        } else {
            selectionButton.isHidden = true
        }
    }

    @IBAction func selectionButtonDidTouch(_ sender: Any) {
        self.address?.selectionState?.didSelect()
    }
}
