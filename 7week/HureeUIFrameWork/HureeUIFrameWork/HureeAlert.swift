//
//  HureeAlert.swift
//  HureeUIFrameWork
//
//  Created by heerucan on 2022/08/16.
//

import UIKit

extension UIViewController {
    
    open func testOpen() { }
    
    public func showHureeAlert(title: String,
                        message: String,
                        buttonTitle: String,
                        buttonAction: @escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let okAction = UIAlertAction(title: buttonTitle, style: .default, handler: buttonAction)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    internal func testInternal() { }
    
    fileprivate func testFilePrivate() { }
    
    private func testPrivate() { }
}

