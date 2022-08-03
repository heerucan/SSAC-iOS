//
//  TranslateViewController.swift
//  NetworkBasic
//
//  Created by heerucan on 2022/07/28.
//

import UIKit

import Alamofire
import SwiftyJSON

final class TranslateViewController: UIViewController {
    
    // MARK: - Property
    
    let textViewPlaceholderText = "번역하고 싶은 문장을 작성해보세요."

    // MARK: - IBOutlet
    
    @IBOutlet weak var userInputTextView: UITextView!
    @IBOutlet weak var userOutputTextView: UITextView!
    
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
    
    func requestTranslatedData(text: String) {
        
        // URL에 다 담는 것이 아님
        
        let url = EndPoint.translateURL
        
        // Header : 메타정보
        // Body : 실질적인 데이터
        
        // Naver 개발 가이드에서 제공하는 걸 보고 따라하자
        let parameter = ["source": "ko",
                         "target": "en",
                         "text": userInputTextView.text!]
        
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.NAVER_ID,
            "X-Naver-Client-Secret": APIKey.NAVER_KEY
        ]
       
        AF.request(url,
                   method: .post,
                   parameters: parameter,
                   headers: header).validate(statusCode: 200..<400).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                // 상태코드 - 값이 없으면 500
                let statusCode = response.response?.statusCode ?? 500

                if statusCode == 200 {
                    self.userOutputTextView.text = json["message"]["result"]["translatedText"].stringValue
                } else {
                    self.userInputTextView.text = json["errorMessage"].stringValue
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - UITextViewDelegate

extension TranslateViewController: UITextViewDelegate {
    
    // 텍스트뷰의 텍스트가 변할 때마다 호출
    func textViewDidChange(_ textView: UITextView) {
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
        if textView.text.isEmpty {
            textView.text = textViewPlaceholderText
            textView.textColor = .lightGray
        }
        
        // 편집이 끝났을 때, 번역해주는 서버 함수를 호출
        guard let textViewText = textView.text else { return }
        requestTranslatedData(text: textViewText)
    }
}
