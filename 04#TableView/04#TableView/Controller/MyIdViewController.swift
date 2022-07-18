//
//  MyIdViewController.swift
//  04#TableView
//
//  Created by formegusto on 2022/07/18.
//

import UIKit

class MyIdViewController: UIViewController {
    @IBOutlet weak var _1: UIView!
    @IBOutlet weak var _2: UIView!
    @IBOutlet weak var _3: UIView!
    @IBOutlet weak var _4: UIView!
    @IBOutlet weak var _5: UIView!
    @IBOutlet weak var _6: UIView!
    @IBOutlet weak var nextBtn: UIButton! {
        didSet {
            nextBtn.isEnabled = false
        }
    }
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        [_1, _2, _3, _4, _5, _6].forEach({ _view in _view.layer.cornerRadius = 8 })
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(sender: UITextField) {
        if sender.text?.isEmpty == true {
            nextBtn.isEnabled = false
        } else {
            nextBtn.isEnabled = true
        }
    }

    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
