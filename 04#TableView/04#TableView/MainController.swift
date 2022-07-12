import UIKit

class MainController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func moveToBasic(_ sender: Any) {
        let storyboard = UIStoryboard(name: "TableViewPractice", bundle: nil)
        let basicVC = storyboard.instantiateViewController(identifier: "TableViewPracticeViewController") as TableViewPracticeViewController
        basicVC.modalPresentationStyle = .fullScreen
        self.present(basicVC, animated: true, completion: nil)
    }
    
    
    @IBAction func moveToSetting(_ sender: Any) {
        let settingApp = UIStoryboard(name: "SettingApp", bundle: nil)
        let settingVC = settingApp.instantiateViewController(identifier: "SettingViewController") as SettingViewController
        self.present(settingVC, animated: true, completion: nil)
    }
}

