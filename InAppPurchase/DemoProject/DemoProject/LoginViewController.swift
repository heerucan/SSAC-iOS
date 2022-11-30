//
//  LoginViewController.swift
//  DemoProject
//
//  Created by heerucan on 2022/11/29.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkTextField: UITextField!
    
    var user = User(email: "", password: "", check: "")
    var validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        descriptionLabel.accessibilityIdentifier = "descriptionLabel"
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        descriptionLabel.text = "로그인 버튼을 눌렀습니다."
        
        user = User(email: emailTextField.text!,
                    password: passwordTextField.text!,
                    check: checkTextField.text!)
        
        if validator.isValidEmail(email: user.email) &&
        validator.isValidPassword(password: user.password) &&
        validator.isEqualPassword(password: user.password, check: user.check) {
            print("로그인 성공")
        } else {
            print("로그인 실패")
        }
        
//        if isValidEmail() && isValidPassword() && isEqualPassword() {
//            print("로그인 성공")
//        } else {
//            print("로그인 실패")
//        }
    }
    
    func isValidEmail() -> Bool {
        guard let email = emailTextField.text else { return false }
        return email.contains("@") && email.count > 8
    }
    
    func isValidPassword() -> Bool {
        guard let password = passwordTextField.text else { return false }
        return password.count >= 6 && password.count < 12
    }
    
    func isEqualPassword() -> Bool {
        guard let password = passwordTextField.text,
              let check = checkTextField.text else { return false }
        return password == check
    }
}

// text 코드에 특정 뷰컨을 선언해서 가져올 경우 해당 뷰컨에서 해당 로직이 없어진다면..? 에 대한 대처
final class Validator {
    
    func isValidEmail(email: String) -> Bool {
        return email.contains("@") && email.count > 8
    }
    
    func isValidPassword(password: String) -> Bool {
        return password.count >= 6 && password.count < 12
    }
    
    func isEqualPassword(password: String, check: String) -> Bool {
        return password == check
    }
}

struct User {
    let email: String
    let password: String
    let check: String
}
