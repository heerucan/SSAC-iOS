//
//  ThirdViewController.swift
//  TMDB
//
//  Created by heerucan on 2022/08/17.
//

import UIKit

final class ThirdViewController: UIViewController {

    // MARK: - @IBOutlet
    
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureAnimation()
    }
    
    @IBAction func touchupSkipButton(_ sender: UIButton) {
        transitionViewController(
            storyboard: Storyboard.main,
            viewController: SearchViewController(),
            transitionStyle: .push)
    }
    
    // MARK: - Configure UI & Layout
    
    private func configureUI() {
        view.backgroundColor = .white
        titleLabel.alpha = 0
    }
    
    private func configureAnimation() {
        UIView.animate(withDuration: 3) {
            self.titleLabel.alpha = 1
        }
    }
}
