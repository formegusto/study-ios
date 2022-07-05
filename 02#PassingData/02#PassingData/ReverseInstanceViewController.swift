import UIKit

class ReverseInstanceViewController: ViewController {
    
    var mainVC: ViewController?
    @IBOutlet weak var messageInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func dismissWithMessage(_ sender: Any) {
        if mainVC != nil {
            mainVC!.mainMessage.text = messageInput.text ?? ""
        }
        self.dismiss(animated: true, completion: nil)
    }
}
