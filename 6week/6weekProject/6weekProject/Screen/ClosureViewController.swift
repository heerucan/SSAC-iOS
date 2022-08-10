//
//  ClosureViewController.swift
//  6weekProject
//
//  Created by heerucan on 2022/08/08.
//

import UIKit

class ClosureViewController: UIViewController {

    @IBOutlet weak var purpleView: UIView!
    @IBOutlet weak var cardView: CardView!
    
    // Frame Based로 하는 것
    var sampleButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        autolayout()
        cardView.posterImageView.backgroundColor = .yellow
        cardView.likeButton.backgroundColor = .orange
        cardView.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
    }
   
    @IBAction func colorPickerButtonClicked(_ sender: UIButton) {
        showAlert(title: "배경색을 바꿀래?", message: "우오아아아아", okTitle: "좋아용") {
            let picker = UIColorPickerViewController()
            self.present(picker, animated: true)
        }
    }
    
    @IBAction func backgroundColorChanged(_ sender: UIButton) {
        showAlert(title: "컬러피커를 띄울까?", message: "우오오오아아앙ㅇ", okTitle: "좋앙") {
            self.view.backgroundColor = .orange
        }
    }
    
    @objc func likeButtonClicked() {
        print("버튼 클릭")
    }
    
    func autolayout() {
        
        // 위치, 크기 추가
        /*
         오토리사이징을 오토레이아웃 제약조건처럼 설정해주는 기능이 내부적으로 구현되어 있음
         이 기능은 디폴트가 true, 하지만 오토레이아웃을 지정해주면 오토리사이징을 안쓰겠다는 의미인 false로 상태가
         내부적으로 변경된다.
         오토리사이징 + 오토레이아웃 = 충돌
         코드 기반 UI -> true
         인터페이스 빌더 기반 UI -> false
         autoresizing -> autolayout constraints
         */
        
        print(sampleButton.translatesAutoresizingMaskIntoConstraints) // trie
        print(cardView.translatesAutoresizingMaskIntoConstraints) // false
        print(purpleView.translatesAutoresizingMaskIntoConstraints) // true
                
        sampleButton.frame = CGRect(x: 100, y: 400, width: 100, height: 100)
        sampleButton.backgroundColor = .red
        view.addSubview(sampleButton)
    }
}
