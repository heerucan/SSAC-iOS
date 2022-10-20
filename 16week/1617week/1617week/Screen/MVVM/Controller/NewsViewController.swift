//
//  NewsViewController.swift
//  1617week
//
//  Created by heerucan on 2022/10/20.
//

import UIKit

final class NewsViewController: UIViewController {
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var numberTextField: UITextField!
    
    // MARK: - Property
    
    var viewModel = NewsViewModel() // 뷰모델 인스턴스 생성

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        numberTextField.text = "3000"
        
        viewModel.pageNumber.bind { value in
            print("bind == \(value)")
            self.numberTextField.text = value
        }
        
        numberTextField.addTarget(self, action: #selector(numberTextFieldChanged), for: .editingChanged)
    }
    
    // MARK: - @objc
    
    @objc func numberTextFieldChanged() {
        // 데이터의 흐름
        /*
         글자가 입력되면, 뷰모델의 pageNumber에게 넘겨주고,
         뷰모델은 쉼표를 찍고 데이터가공을 해서
         결과를 컨트롤러에게 넘겨서 화면에 보여줘야 함
         */
        
        print(#function)
        guard let text = numberTextField.text else { return }
        viewModel.changePageNumberFormat(text: text)
    }
}
