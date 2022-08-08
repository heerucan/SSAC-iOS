//
//  ClosureViewController.swift
//  6weekProject
//
//  Created by heerucan on 2022/08/08.
//

import UIKit

class ClosureViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
}
