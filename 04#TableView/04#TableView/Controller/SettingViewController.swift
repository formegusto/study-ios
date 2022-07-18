import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var settingTableView: UITableView!
    @IBOutlet weak var prevBtn: UIImageView!

    var menuStore: [[Menu]] = [
        [
        Menu("airplane", UIColor(red: 250 / 255, green: 129 / 255, blue: 2 / 255, alpha: 1), "에어플레인 모드"),
         Menu("wifi", UIColor(red: 9 / 255, green: 95 / 255, blue: 253 / 255, alpha: 1), "Wi-Fi"),
         Menu("bonjour", UIColor(red: 9 / 255, green: 95 / 255, blue: 253 / 255, alpha: 1), "Bluetooth"),
         Menu("antenna.radiowaves.left.and.right", UIColor(red: 46 / 255, green: 192 / 255, blue: 70 / 255, alpha: 1), "셀룰러"),
         Menu("personalhotspot", UIColor(red: 46 / 255, green: 192 / 255, blue: 70 / 255, alpha: 1), "개인용 핫스팟")
        ],
        [
        Menu("bell.badge.fill", UIColor(red: 249 / 255, green: 35 / 255, blue: 37 / 255, alpha: 1), "알림"),
         Menu("speaker.wave.3.fill", UIColor(red: 249 / 255, green: 12 / 255, blue: 67 / 255, alpha: 1), "사운드 및 햅틱"),
         Menu("moon.fill", UIColor(red: 68 / 255, green: 59 / 255, blue: 204 / 255, alpha: 1), "집중 모드"),
        Menu("hourglass", UIColor(red: 68 / 255, green: 59 / 255, blue: 204 / 255, alpha: 1), "스크린 타임"),
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "ProfileCell", bundle: nil)
        self.settingTableView.register(nib, forCellReuseIdentifier: "ProfileCell")
        self.settingTableView.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: "MenuCell")
        
        self.settingTableView.separatorStyle = .none
        
         
        self.settingTableView.dataSource = self
        self.settingTableView.delegate = self
        
        self.title = "설정"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let closeBtn = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(prevBtnAction))
        self.navigationItem.rightBarButtonItem = closeBtn
//        self.setEvent()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
//    func setEvent() {
//        self.prevBtn.isUserInteractionEnabled = true
//        self.prevBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(prevBtnAction)))
//    }
    
    @objc func prevBtnAction(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return menuStore[section - 1].count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if indexPath.section == 0 {
            let cell = self.settingTableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = self.settingTableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
            
            cell.setViewStyle(isFirst: indexPath.row == 0 ? true : false
                                             ,isLast:indexPath.row == menuStore[indexPath.section - 1].count - 1 ? true : false,
                                             menu: menuStore[indexPath.section - 1][indexPath.row])
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuStore.count + 1
    }

    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return CGFloat(16)
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = UIView()
//        header.backgroundColor = .clear
//        return header
//    }
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if indexPath.section == 0 {
            let myIdVC = MyIdViewController(nibName: "MyIdViewController", bundle: nil)
            self.present(myIdVC, animated: true, completion: nil)
        } else {
            let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
            let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            detailVC.title = menuStore[indexPath.section - 1][indexPath.row].title
            
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
}
