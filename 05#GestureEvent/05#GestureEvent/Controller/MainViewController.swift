import UIKit

enum DragType {
    case X
    case Y
    case none
}
class MainViewController: UIViewController {

    var dragType: DragType = .none {
        didSet {
            self.myView.dragType = dragType
        }
    }
    let myView = DraggableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myView.center = self.view.center
        myView.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        myView.backgroundColor = .red
        
        self.view.addSubview(myView)
    }

    @IBAction func setXY(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.dragType = .X
        case 1:
            self.dragType = .Y
        case 2:
            self.dragType = .none
        default:
            break
        }
    }
    
}

