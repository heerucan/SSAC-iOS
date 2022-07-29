//
//  TranslateViewController.swift
//  NetworkBasic
//
//  Created by heerucan on 2022/07/28.
//

import UIKit

final class TranslateViewController: UIViewController {
    
    // MARK: - Property
    
    let textViewPlaceholderText = "번역하고 싶은 문장을 작성해보세요."

    // MARK: - IBOutlet
    
    @IBOutlet weak var userInputTextView: UITextView!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextView()
    }

    // MARK: - Custom Method
    
    func configureTextView() {
        userInputTextView.delegate = self
        userInputTextView.text = textViewPlaceholderText
        userInputTextView.textColor = .lightGray
        userInputTextView.font = UIFont(name: "Pretendard-Medium", size: 30)
    }
}

// MARK: - UITextViewDelegate

extension TranslateViewController: UITextViewDelegate {
    
    // 텍스트뷰의 텍스트가 변할 때마다 호출
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text!)
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    // 편집이 시작될 때, 커서가 시작될 때
    // 텍스트뷰 글자: 플레이스 홀더랑 글자가 같으면 clear
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("🥳Begin")
    }
    
    // 편집이 끝났을 때, 커서가 없어지는 순간
    // 텍스트뷰 글자: 사용자가 아무 글자도 안 썼으면 플레이스 홀더 글자 보이게 해라
    func textViewDidEndEditing(_ textView: UITextView) {
        print("End")
        if textView.text.isEmpty {
            textView.text = textViewPlaceholderText
            textView.textColor = .lightGray
        }
    }
}
