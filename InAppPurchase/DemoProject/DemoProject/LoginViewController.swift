//
//  LoginViewController.swift
//  DemoProject
//
//  Created by heerucan on 2022/11/29.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.accessibilityIdentifier = "descriptionLabel"
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        descriptionLabel.text = "로그인 버튼을 눌렀습니다."
    }
}
