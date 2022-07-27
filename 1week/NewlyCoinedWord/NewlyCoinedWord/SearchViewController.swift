//
//  SearchViewController.swift
//  NewlyCoinedWord
//
//  Created by heerucan on 2022/07/10.
//

import UIKit

enum Word: String, CaseIterable {
    case 캘박, 좋댓구알, 구취, 꾸안꾸, 실매
    
//    var word: String {
//        switch self {
//        case .캘박: return "캘박"
//        case .좋댓구알: return "좋댓구알"
//        case .구취: return "구취"
//        case .꾸안꾸: return "꾸안꾸"
//        case .실매: return "실매"
//        }
//    }
    
    var mean: String {
        switch self {
        case .캘박: return "캘린더에 일정을 픽스한다는 뜻이다"
        case .좋댓구알: return "좋아요, 댓글, 구독, 알림설정을 의미한다"
        case .구취: return "구독 취소를 의미한다"
        case .꾸안꾸: return "꾸민듯 안꾸민듯이라는 뜻이다"
        case .실매: return "실시간 매니저를 의미한다"
        }
    }
}

class SearchViewController: UIViewController {
    
    // MARK: - @IBOutlet
        
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet var tagButtonList: [UIButton]!
    @IBOutlet weak var resultLabel: UILabel!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextField()
//        Word.allCases.forEach {
//            wordArray.append($0.rawValue)
//        }
    }
    
    // MARK: - @IBAction
    
    @IBAction func tapGestureRecoginzer(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func tagButtonClicked(_ sender: UIButton) {
        searchTextField.text = sender.currentTitle
        clickedSearchButton(sender)
    }
    
    @IBAction func clickedSearchButton(_ sender: UIButton) {
        print("눌러짐")
        setButton()
        searchWords()
        view.endEditing(true)
    }
    
    // MARK: - UDF
    
    func setButton() {
        tagButtonList.forEach {
            $0.titleLabel?.numberOfLines = 1
            $0.setTitleColor(.black, for: .normal)
            $0.layer.cornerRadius = 10
            $0.layer.borderColor = UIColor.black.cgColor
            $0.layer.borderWidth = 1
            $0.setTitle(Word.allCases.map { $0.rawValue }.randomElement(), for: .normal)
        }
        
        resultLabel.text = Word.allCases.map { $0.mean }.randomElement()
    }

    func setTextField() {
        searchTextField.delegate = self
        searchTextField.font = .systemFont(ofSize: 17)
        searchTextField.placeholder = "검색하고 싶은 신조어를 입력하세요"
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: searchTextField.frame.height))
        searchTextField.leftView = paddingView
        searchTextField.leftViewMode = .always
        searchTextField.rightView = paddingView
        searchTextField.rightViewMode = .always
    }
    
    
    func searchWords() {
        guard let searchText = searchTextField.text else { return }
        
        
//        resultLabel.text = Word.mean.
        
//        if Dictionary.word.array.contains(searchText) {
//            resultLabel.text = Dictionary.meaning.array[searchText]
//
//            if let index = Dictionary.word.array.firstIndex(where: { $0 == searchText} ) {
//                Dictionary.word.array.remove(at: index)
//                Dictionary.word.array.shuffle()
//                Dictionary.word.array.insert(searchText, at: 0)
//                setButton()
//            }
//
//        } else {
//            resultLabel.text = "없는 신조어이거나 뜻을 찾을 수 없습니다."
//        }
    }
}

// MARK: - UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchWords()
        return textField.resignFirstResponder()
    }
}
