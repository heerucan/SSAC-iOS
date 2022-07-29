//
//  LottoViewController.swift
//  NetworkBasic
//
//  Created by heerucan on 2022/07/28.
//

import UIKit

final class LottoViewController: UIViewController {
    
    // MARK: - Property
    
    let numberList: [Int] = Array(1...1025).reversed()
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var numberTextField: UITextField!
    
    var lottoPickerView = UIPickerView()
    var toolBar = UIToolbar()
    let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(touchupDoneButton))
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePickerView()
        configureTextField()
        configureToolbar()
    }
    
    // MARK: - Custom Method
    
    private func configurePickerView() {
        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
    }
    
    private func configureTextField() {
        numberTextField.inputView = lottoPickerView
        numberTextField.delegate = self
        numberTextField.resignFirstResponder()
        numberTextField.textContentType = .oneTimeCode // 인증번호
    }
    
    func configureToolbar() {
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        numberTextField.inputAccessoryView = toolBar
    }
    
    // MARK: - @objc
    
    @objc func touchupDoneButton() {
        let row = self.lottoPickerView.selectedRow(inComponent: 0)
        self.lottoPickerView.selectRow(row, inComponent: 0, animated: false)
        self.numberTextField.text = "\(self.numberList[row])회차 로또"
        self.numberTextField.resignFirstResponder()
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        numberTextField.text = "\(numberList[row])회차 로또"
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // 각각의 열에 어떤 글자를 넣어줄 건데?
        return "\(numberList[row])회차"
    }
}

// MARK: - UITextFieldDelegate

extension LottoViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        numberTextField.isUserInteractionEnabled = false
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        numberTextField.isUserInteractionEnabled = true
    }
}

// MARK: - 커스텀클래스

class CustomTextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) ||
            action == #selector(UIResponderStandardEditActions.copy(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}
