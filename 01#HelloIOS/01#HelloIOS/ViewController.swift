import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var testButton: UIButton!
    
    @IBAction func doSomething(_ sender: Any) {
        testButton.backgroundColor = .orange
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(identifier: "Detail") as DetailVC
        
        self.present(detailVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        testButton.backgroundColor = .red
    }

}

