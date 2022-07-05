import UIKit

class InstancePropertyViewController: ViewController {
    var message: String = ""
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.text = message
    }
}
