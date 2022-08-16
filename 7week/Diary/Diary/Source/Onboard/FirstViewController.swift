//
//  FirstViewController.swift
//  Diary
//
//  Created by heerucan on 2022/08/16.
//

import UIKit

import HureeUIFrameWork

class FirstViewController: UIViewController {
    
    let myView = MyView()
        
    // MARK: - @IBOutlet

    @IBOutlet weak var tutorialLabel: UILabel!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var blackViewConstraint: NSLayoutConstraint!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        myView.changeBackgroundColor(.red)
    }
    
    // MARK: - Configure UI & Layout
    
    private func configureUI() {
        tutorialLabel.numberOfLines = 0
        tutorialLabel.alpha = 0
        tutorialLabel.font = .boldSystemFont(ofSize: 25)
        tutorialLabel.text = """
        일기 씁시다!
        잘 써봅시다!
        """
        blackView.alpha = 0
        blackView.backgroundColor = .black
        UIView.animate(withDuration: 3) {
            self.tutorialLabel.alpha = 1
        } completion: { _ in
            self.configureBlackViewAnimation()
        }
    }
    
    private func configureBlackViewAnimation() {
        UIView.animate(withDuration: 1) {
            self.blackView.alpha = 1
            self.blackViewConstraint.constant += 250
            self.view.layoutIfNeeded()
        } completion: { _ in
            print("🪲 blackView끝")
        }
    }
}

class MyView: HureeView {
    override func changeBackgroundColor(_ color: UIColor) {
        super.changeBackgroundColor(color)
        print("다른 모듈에 있는 HureeView는 open이기 때문에 서브클래싱이 가능하고, 오버라이딩도 가능하다.")
    }
}
