import UIKit

class TableViewPracticeViewController: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var selectObserving: UILabel!
    @IBOutlet weak var myTable: UITableView!
    var items: [String] = ["item1", "item2", "item3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.titleLabel?.isHidden = true
        
        myTable.dataSource = self
        myTable.delegate = self
    }

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension TableViewPracticeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.myTable.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        cell.textLabel?.text = self.items[indexPath.row]
        return cell
    }
    
    
}

extension TableViewPracticeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let text = items[indexPath.row]
        
        self.selectObserving.text = "selected cell : \(text)"
    }
}

