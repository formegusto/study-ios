import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var settingTableView: UITableView!
    @IBOutlet weak var prevBtn: UIImageView!
    let menuStore: [Menu] = [
        Menu("airplane", UIColor(red: 250 / 255, green: 129 / 255, blue: 2 / 255, alpha: 1), "에어플레인 모드"),
        Menu("wifi", UIColor(red: 9 / 255, green: 95 / 255, blue: 253 / 255, alpha: 1), "Wi-Fi"),
        Menu("bonjour", UIColor(red: 9 / 255, green: 95 / 255, blue: 253 / 255, alpha: 1), "Bluetooth"),
        Menu("antenna.radiowaves.left.and.right", UIColor(red: 46 / 255, green: 192 / 255, blue: 70 / 255, alpha: 1), "셀룰러"),
        Menu("personalhotspot", UIColor(red: 46 / 255, green: 192 / 255, blue: 70 / 255, alpha: 1), "개인용 핫스팟")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "ProfileCell", bundle: nil)
        self.settingTableView.register(nib, forCellReuseIdentifier: "ProfileCell")
        self.settingTableView.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: "MenuCell")
        
        self.settingTableView.separatorStyle = .none
        
        
        self.settingTableView.dataSource = self
        self.settingTableView.delegate = self
        
        self.setEvent()
    }
    
    func setEvent() {
        self.prevBtn.isUserInteractionEnabled = true
        self.prevBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(prevBtnAction)))
    }
    
    @objc func prevBtnAction(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return menuStore.count
        } else {
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell?
        
        if indexPath.section == 0 {
            cell = self.settingTableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath)
        } else {
            cell = self.settingTableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
            
            (cell as! MenuCell).setViewStyle(isFirst: indexPath.row == 0 ? true : false
                                             ,isLast:indexPath.row == menuStore.count - 1 ? true : false,
                                             menu: menuStore[indexPath.row])
        }
        
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(16)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .clear
        return header
    }
    
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch indexPath.row {
//            case 0:
//                return UITableView.automaticDimension
//            default:
//                return 48
//        }
        return UITableView.automaticDimension
    }
    
}
