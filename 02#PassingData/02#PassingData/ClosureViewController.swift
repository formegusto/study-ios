import UIKit

class ClosureViewController: ViewController {
    
    var myClosure: ((_ msg:String) -> Void)?
    @IBOutlet weak var msgInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func dismissWithSend(_ sender: Any) {
        let _msg = self.msgInput.text ?? ""
        myClosure?(_msg)
        self.dismiss(animated: true, completion: nil)
    }
    
}
