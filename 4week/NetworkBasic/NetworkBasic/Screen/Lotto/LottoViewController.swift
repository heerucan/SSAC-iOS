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
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePickerView()
        configureTextField()
    }

    // MARK: - Custom Method
    
    private func configurePickerView() {
        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
    }
    
    private func configureTextField() {
        numberTextField.inputView = lottoPickerView
        
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
