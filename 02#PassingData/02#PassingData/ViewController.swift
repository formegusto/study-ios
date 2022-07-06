import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationName = Notification.Name("send msg from notification")
        NotificationCenter.default.addObserver(self, selector: #selector(receiveFromNotification), name: notificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // Remove
        // NotificationCenter.default.removeObserver(self, name: notificationName, object: nil)
    }
    
    @objc func keyboardWillShow() {
        print("Will Show")
    }
    
    @objc func receiveFromNotification(notification: Notification) {
        if let str = notification.userInfo?["msg"] as? String {
            self.mainMessage?.text = str
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mySegue" {
            if let segueVC = segue.destination as? SegueViewController {
                segueVC.message = "안녕하세요. 세구에에 보냅니다."
            }
        }
    }

    @IBAction func moveToInstanceProperty(_ sender: Any) {
        let instancePropertyVC = InstancePropertyViewController(nibName: "InstancePropertyViewController", bundle: nil)
        instancePropertyVC.message = "안녕하세요. 메인페이지 메시지 입니다."
        // 주의할점
        // - viewDidLoad 시점에 messageLabel이 연결된다. 처음 생성될 때와
        // viewDidLoad가 호출되기 전에는 nil 값이다.
        // 아래와 같은 passing data는 진행하면 안된다.
        // instancePropertyVC.messageLabel.text = "안녕하세요. 메인페이지 메시지 입니다."

        self.present(instancePropertyVC, animated: true, completion: nil)
        // 이거는 화면이 전부 올라온 후에 진행되기 때문에 정상 실행된다.
        // instancePropertyVC.messageLabel.text = "안녕하세요. 메인페이지 메시지 입니다.__2"
    }

    @IBAction func moveToReverseInstance(_ sender: Any) {
        let reverseInstanceVC = ReverseInstanceViewController(nibName: "ReverseInstanceViewController", bundle: nil)
        
        reverseInstanceVC.mainVC = self
        
        self.present(reverseInstanceVC, animated: true, completion: nil)
    }
    @IBAction func moveToDelegate(_ sender: Any) {
        let delegateVC = DelegateViewController(nibName: "DelegateViewController", bundle: nil)
        
        delegateVC.delegate = self
        
        self.present(delegateVC, animated: true)
    }
    @IBAction func moveToClosure(_ sender: Any) {
        let closureVC = ClosureViewController(nibName: "ClosureViewController", bundle: nil)
        closureVC.myClosure = { self.mainMessage.text = $0 }
        self.present(closureVC, animated: true, completion: nil)
    }
    
    @IBAction func moveToNotification(_ sender: Any) {
        let notificationVC = NotificationViewController(nibName: "NotificationViewController", bundle: nil)
        self.present(notificationVC, animated: true, completion: nil)
    }
}

extension ViewController: DelegateViewControllerDelegate {
    func passString(string: String) {
        self.mainMessage.text = string
    }
}

