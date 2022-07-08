//
//  SignUpViewController.swift
//  Netflix
//
//  Created by heerucan on 2022/07/07.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var moreInfoButton: UIButton!
    @IBOutlet weak var toggleSwitch: UISwitch!
    
    var placeholder = ["이메일 주소 또는 전화번호", "비밀번호", "닉네임", "위치", "추천코드입력"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField(emailTextField, placeholder: placeholder[0], keyboardType: .emailAddress)
        configureTextField(passwordTextField, placeholder: placeholder[1])
        configureTextField(nicknameTextField, placeholder: placeholder[2])
        configureTextField(locationTextField, placeholder: placeholder[3])
        configureTextField(codeTextField, placeholder: placeholder[4], keyboardType: .numberPad)
        configureButton()
        configureSwitch()
    }
 
    @IBAction func tapGesture(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func joinButtonClicked(_ sender: UIButton) {
        if emailTextField.text == "" {
            print("이메일 필수입력!")
        }
        
        if passwordTextField.text!.count <= 6 {
            print("비밀번호 최소 6자 이상!")
        }
        view.endEditing(true)
    }
    
    // 1. 함수 및 파라미터 사용하는 방법
    func configureTextField(_ textField: UITextField,
                            placeholder: String,
                            keyboardType: UIKeyboardType = .default) {
        
        textField.backgroundColor = .darkGray
        textField.textColor = .white
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.keyboardType = keyboardType
        textField.placeholder = placeholder
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        codeTextField.delegate = self
    }
    
    // 2. 배열해서 만드는 방법
    func configureTextField() {
        let textFieldArray = [emailTextField, passwordTextField, nicknameTextField, locationTextField, codeTextField]

        [emailTextField, passwordTextField, nicknameTextField, locationTextField, codeTextField].forEach { view in
            view?.backgroundColor = .darkGray
            view?.textColor = .white
            view?.textAlignment = .center
            view?.borderStyle = .roundedRect
        }

        for i in (0...textFieldArray.count-1) {
            textFieldArray[i]?.placeholder = placeholder[i]
            textFieldArray[i]?.attributedPlaceholder = NSAttributedString(string: placeholder[i], attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        }
        
        emailTextField.keyboardType = .emailAddress
        codeTextField.keyboardType = .numberPad
    }
    
    func configureButton() {
        joinButton.setTitle("회원가입", for: .normal)
        joinButton.setTitleColor(.black, for: .normal)
        joinButton.setTitleColor(.lightGray, for: .highlighted)
        joinButton.backgroundColor = .white
        joinButton.layer.cornerRadius = 10
        moreInfoButton.setTitle("추가 정보 입력", for: .normal)
        moreInfoButton.setTitleColor(.white, for: .normal)
    }
    
    func configureSwitch() {
        toggleSwitch.onTintColor = .red
        toggleSwitch.tintColor = .lightGray
        toggleSwitch.setOn(true, animated: true)
        toggleSwitch.backgroundColor = .lightGray
        toggleSwitch.layer.cornerRadius = toggleSwitch.frame.height / 2
    }
    
    
}

extension SignUpViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let codeText = codeTextField.text else { return false }
        
        if codeText.hasCharacters() {
            return true
        } else {
             return false
        }
    }
}

extension String {
    func hasCharacters() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[0-9]$", options: .caseInsensitive)
            if let _ = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count)) {
                return true
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
        return false
    }
}
