import UIKit

class NotificationViewController: ViewController {

    @IBOutlet weak var msgInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func dismissWithSend(_ sender: Any) {
        let notificationName = Notification.Name("send msg from notification")
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: ["msg": msgInput.text ?? ""])
        self.dismiss(animated: true, completion: nil)
    }
}
