//
//  ProfileViewController.swift
//  Diary
//
//  Created by heerucan on 2022/08/18.
//

import UIKit

extension NSNotification.Name {
    static let saveButton = NSNotification.Name("saveButtonNotification")
    static let test = NSNotification.Name("TEST")
}

final class ProfileViewController: UIViewController {
    
    // MARK: - Property
    
    var saveButtonActionHandler: (() -> ())?
    var saveButtonActionHandler2: ((String) -> ())?
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이름을 입력하세요"
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.font = .boldSystemFont(ofSize: 15)
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .orange
        button.addTarget(self, action: #selector(touchupSaveButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(saveButtonNotification(_:)),
                                               name: .test,
                                               object: nil)
    }
    
    // MARK: - Configure UI & Layout
    
    private func configureUI() {
        view.backgroundColor = .brown
    }
    
    private func configureLayout() {
        view.addSubviews([nameTextField, saveButton])
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: .test,
                                                  object: nil)
    }
    
    // MARK: - Custom Method
    
    
    // MARK: - @objc
    
    @objc func saveButtonNotification(_ notification: Notification) {
        print(#function, "실행됨?")
        guard let name = notification.userInfo?["name"] as? String else { return }
        self.nameTextField.text = name
    }
    
    @objc func touchupSaveButton() {
        
        /* 1. Closure
         이때 함수타입을 가진 프로퍼티를 호출해서 동작시키는 것임
         물음표가 왜 괄호 앞에 붙는 것? -> 실제로 실행하고 싶다할 때 괄호를 붙이는 것 */
        //        saveButtonActionHandler?()
        //        saveButtonActionHandler2?(nameTextField.text!)
        
        // 2. Notification
        NotificationCenter.default.post(name: .saveButton,
                                        object: nil,
                                        userInfo: ["name": nameTextField.text!,
                                                   "value": 12345])
        
        self.dismiss(animated: true, completion: nil)
    }
    
}