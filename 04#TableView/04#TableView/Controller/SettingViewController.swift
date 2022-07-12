import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var settingTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "ProfileCell", bundle: nil)
        self.settingTableView.register(nib, forCellReuseIdentifier: "ProfileCell")
        
        self.settingTableView.dataSource = self
    }

}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let profileCell = self.settingTableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath)
        return profileCell
    }
}
