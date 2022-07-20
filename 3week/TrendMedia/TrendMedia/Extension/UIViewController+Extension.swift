//
//  UIViewController+Extension.swift
//  TrendMedia
//
//  Created by heerucan on 2022/07/19.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setBackgroundColor() {
        view.backgroundColor = .orange
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "제목", message: "메시지", preferredStyle: .alert)
        let ok = UIAlertAction(title: "예", style: .default)
        let cancel = UIAlertAction(title: "취소", style: .destructive)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}
