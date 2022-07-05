import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}

extension ViewController: DelegateViewControllerDelegate {
    func passString(string: String) {
        self.mainMessage.text = string
    }
}

