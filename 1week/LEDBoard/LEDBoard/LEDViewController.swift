//
//  LEDViewController.swift
//  LEDBoard
//
//  Created by heerucan on 2022/07/06.
//

import UIKit

class LEDViewController: UIViewController {
    
    @IBOutlet weak var writeTextField: UITextField!
    @IBOutlet weak var changeColorButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var backView: UIView!
    
    // 1. 아울렛 컬렉션
    @IBOutlet var buttonList: [UIButton]!
    
    @IBOutlet var tagGestureRecognizer: UITapGestureRecognizer!
    
    // 2. 반복문으로 버튼 리스트에 직접 추가
    var buttonArray: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabel()
        configureTextField()
        configureButton(sendButton,
                        title: "전송",
                        highlightedTitle: "보내",
                        buttonBackgroundColor: .black)
        configureButton(changeColorButton,
                        title: "색깔",
                        highlightedTitle: "바꿔",
                        buttonBackgroundColor: .black)
    }
    
    func configureButton(_ buttonName: UIButton, title: String, highlightedTitle: String, buttonBackgroundColor bgColor: UIColor) {
        buttonName.setTitle(title, for: .normal)
        buttonName.setTitle(highlightedTitle, for: .highlighted)
        buttonName.backgroundColor = bgColor
        buttonName.setTitleColor(.white, for: .normal)
        buttonName.layer.cornerRadius = 3
        buttonName.layer.borderWidth = 3
        buttonName.layer.borderColor = UIColor.systemOrange.cgColor
        buttonName.setTitleColor(.gray, for: .highlighted)
    }
    
    func configureTextField() {
        writeTextField.placeholder = "내용을 작성해주세요"
        writeTextField.text = "루히짱!"
        writeTextField.keyboardType = .default
        writeTextField.delegate = self
    }
    
    func configureLabel() {
        resultLabel.text = "이곳에 글자가 보여요"
        resultLabel.font = .boldSystemFont(ofSize: 30)
        resultLabel.textColor = .white
        resultLabel.numberOfLines = 0
    }
    
    @IBAction func tapGestureClicked(_ sender: UITapGestureRecognizer) {
        view.backgroundColor = .darkGray
        view.endEditing(true)
        backView.isHidden = !backView.isHidden
    }
    
    @IBAction func sendButtonClicked(_ sender: UIButton) {
        resultLabel.text = writeTextField.text
    }
    
    @IBAction func exampleButton(_ sender: UIButton) {
        view.endEditing(true)
    }

    @IBAction func textFieldDidEndOnExit(_ sender: UITextField) {
        print("textFieldDidEndOnExit")
        print(sender)
    }
}

extension LEDViewController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//    }
}
