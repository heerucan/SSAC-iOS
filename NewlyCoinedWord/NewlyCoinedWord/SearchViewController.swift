//
//  SearchViewController.swift
//  NewlyCoinedWord
//
//  Created by heerucan on 2022/07/10.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Property
    
    var words = ["캘박", "좋댓구알", "구취", "꾸안꾸", "실매"]
    var wordsDictionary = ["캘박": "캘린더에 일정을 픽스한다는 뜻이다",
                           "좋댓구알": "좋아요, 댓글, 구독, 알림설정을 의미한다",
                           "구취": "구독취소를 의미한다",
                           "꾸안꾸": "꾸민듯 안꾸민듯이라는 뜻이다",
                           "실매": "실시간 매니저를 의미한다"]

    // MARK: - @IBOutlet
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet var tagButtonList: [UIButton]!
    @IBOutlet weak var resultLabel: UILabel!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextField()
    }
    
    // MARK: - @IBAction
    
    @IBAction func tapGestureRecoginzer(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func clickedSearchButton(_ sender: UIButton) {
        setButton()
        searchWords()
        view.endEditing(true)
    }
    
    // MARK: - UDF
    
    func setButton() {
        for i in (0...tagButtonList.count-1) {
            tagButtonList[i].setTitle(words[i], for: .normal)
            tagButtonList[i].setTitleColor(.black, for: .normal)
            tagButtonList[i].layer.cornerRadius = 10
            tagButtonList[i].layer.borderColor = UIColor.black.cgColor
            tagButtonList[i].layer.borderWidth = 1
        }
    }

    func setTextField() {
        searchTextField.delegate = self
        searchTextField.font = .systemFont(ofSize: 17)
        searchTextField.placeholder = "검색하고 싶은 신조어를 입력하세요"
    }
    
    func searchWords() {
        guard let searchText = searchTextField.text else { return }
        
        if words.contains(searchText) {
            resultLabel.text = wordsDictionary[searchText]
            
            if let index = words.firstIndex(where: { $0 == searchText} ) {
                words.remove(at: index)
                words.insert(searchText, at: 0)
                setButton()
            }
            
        } else {
            resultLabel.text = "없는 신조어이거나 뜻을 찾을 수 없습니다."
        }
    }
}

// MARK: - UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchWords()
        return textField.resignFirstResponder()
    }
}
