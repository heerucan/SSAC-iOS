//
//  LottoViewController.swift
//  NetworkBasic
//
//  Created by heerucan on 2022/07/28.
//

import UIKit

final class LottoViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var lottoPickerView: UIPickerView!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePickerView()
    }

    // MARK: - Custom Method
    
    private func configurePickerView() {
        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? 10 : 20
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(component, row)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // 각각의 열에 어떤 글자를 넣어줄 건데?
        return "\(row)번째 루희짱"
    }
}
