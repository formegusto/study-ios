import UIKit

class DetailVC: ViewController {

    // 화면 올릴 준비가 되었을 때
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("View Did Load")
    }

    // 화면 올리기 직전
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("View Will Appear")
    }
    
    // 화면에 올린 후
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("View Did Appear")
    }
    
    // 화면이 내려가기 전
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("View Will Disappear")
    }
    
    // 화면이 내려간 후
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("View Did Disappear")
    }
}
