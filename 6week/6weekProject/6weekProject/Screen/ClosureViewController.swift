//
//  ClosureViewController.swift
//  6weekProject
//
//  Created by heerucan on 2022/08/08.
//

import UIKit

class ClosureViewController: UIViewController {

    @IBOutlet weak var cardView: CardView!
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
