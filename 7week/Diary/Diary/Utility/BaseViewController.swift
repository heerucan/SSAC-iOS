//
//  BaseViewController.swift
//  Diary
//
//  Created by heerucan on 2022/08/19.
//

import UIKit

import HureeUIFrameWork

class BaseViewController: UIViewController {
    
    // MARK: - Property
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureDelegate()
    }
    
    // MARK: - Configure UI & Layout
    
    func configureUI() {
        view.backgroundColor = .white
    }
        
    func configureDelegate() { }
    
    // MARK: - Custom Method
    
    func showAlert(title: String,
                   message: String?,
                   buttonTitle: String,
                   buttonAction: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title,
                                      message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: buttonTitle, style: .default, handler: buttonAction)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}
