//
//  UIView+.swift
//  TMDB
//
//  Created by heerucan on 2022/08/03.
//

import UIKit

extension UIView {
    func makeRound() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    func makeShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
        layer.masksToBounds = false
    }
}
