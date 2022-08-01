//
//  LottoViewController.swift
//  NetworkBasic
//
//  Created by heerucan on 2022/07/28.
//

import UIKit

import Alamofire
import SwiftyJSON

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
        requestLotto(number: 1025)
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
    
    func requestLotto(number: Int) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        
        // AF : 기본적으로 200 ~ 299 status Code 성공
        // 따로 399까지 성공으로 주고 싶으면 아래처럼 매개변수를 주면 된다. .validate(statusCode: 200..<400)
        AF.request(url, method: .get).validate(statusCode: 200..<400).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                // int면 옵셔널 / intValue면 항상 값이 있음
                let date = json["drwNoDate"].stringValue
                let bonus = json["bnusNo"].intValue

                self.numberTextField.text = date

            case .failure(let error):
                print(error)
            }
        }
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
        requestLotto(number: numberList[row])
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
