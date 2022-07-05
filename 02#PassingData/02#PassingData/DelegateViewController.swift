import UIKit

protocol DelegateViewControllerDelegate: AnyObject {
    func passString(string: String) -> Void
}

class DelegateViewController: ViewController {
    
    weak var delegate: DelegateViewControllerDelegate?
    @IBOutlet weak var messageInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func dismissWithMessage(_ sender: Any) {
        if delegate != nil {
            let passMessage = messageInput.text ?? ""
            delegate?.passString(string: passMessage)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}
