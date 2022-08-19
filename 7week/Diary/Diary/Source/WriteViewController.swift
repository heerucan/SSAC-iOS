//
//  WriteViewController.swift
//  Diary
//
//  Created by heerucan on 2022/08/19.
//

import UIKit

import SnapKit

class WriteViewController: BaseViewController {
    
    var mainView = WriteView()
    
    override func loadView() { // super.loadView 호출금지
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        super.configureUI()
        mainView.titleTextField.addTarget(self, action: #selector(titleTextFieldClicked(_:)), for: .editingDidEndOnExit)
    }
    
    override func configureDelegate() {
        
    }
    
    @objc func titleTextFieldClicked(_ textField: UITextField) {
        guard let text = textField.text,
                text.count > 0 else {
            showAlert(title: "제목을 입력해주세요",
                      message: nil,
                      buttonTitle: "확인",
                      buttonAction: nil)
            return
        }
    }
}
