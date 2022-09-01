//
//  LoginViewController.swift
//  9weekProject
//
//  Created by heerucan on 2022/09/01.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Property
    
    var viewModel = LoginViewModel()

    // MARK: - @IBOutlet
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 지금은 받은 걸 그대로 뱉는 중
        viewModel.name.bind { text in
            self.nameTextField.text = text
        }
        
        viewModel.password.bind { text in
            self.passwordTextField.text = text
        }
        
        viewModel.email.bind { text in
            self.emailTextField.text = text
        }
        
        viewModel.isValid.bind { bool in
            self.loginButton.isEnabled = bool
            self.loginButton.backgroundColor = bool ? .systemBlue : .lightGray
        }
    }
    
    // MARK: - @IBAction
    
    // 입력될 때마다 몬가를 할 거야!
    @IBAction func nameTextFieldTextChanged(_ sender: Any) {
        viewModel.name.value = nameTextField.text!
        viewModel.checkValidation()
    }
    
    @IBAction func emailTextFieldTextChanged(_ sender: Any) {
        viewModel.email.value = emailTextField.text!
        viewModel.checkValidation()
    }
    
    @IBAction func passwordTextFieldTextChanged(_ sender: Any) {
        viewModel.password.value = passwordTextField.text!
        viewModel.checkValidation()
    }
    
    @IBAction func touchupLoginButton(_ sender: UIButton) {
        viewModel.signIn {
            // 화면전환 코드
            self.view.backgroundColor = .orange
        }
    }
}
