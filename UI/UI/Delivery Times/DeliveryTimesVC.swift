import UIKit
import Helpers

extension DeliveryTimesVC: StoryboardInstantiatable {
    static var storyboardName: String { "DeliveryTimes" }
}

final class DeliveryTimesVC: UIViewController {
    struct Props {
        let minDate: Date
        let maxDate: Date
        let selectedDate: Date

        let didSelectNewDate: (Date) -> Void

        static let defaultValue = Props(minDate: Date(), maxDate: Date(), selectedDate: Date(), didSelectNewDate: { _ in })
    }

    @IBOutlet weak var datePicker: UIDatePicker!

    private var props = Props.defaultValue

    func render(props: Props) {
        self.props = props
        if isViewLoaded {
            datePicker.date = props.selectedDate
            datePicker.maximumDate = props.maxDate
            datePicker.minimumDate = props.minDate
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        render(props: props)
    }

    @IBAction func didChangeDatePickerValue(_ sender: Any) {
        props.didSelectNewDate(datePicker.date)
    }
}
