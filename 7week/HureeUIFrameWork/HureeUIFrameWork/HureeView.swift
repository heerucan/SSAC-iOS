//
//  HureeView.swift
//  HureeUIFrameWork
//
//  Created by heerucan on 2022/08/16.
//

import UIKit

open class HureeView: UIView {
    open func changeBackgroundColor(_ color: UIColor) {
        self.backgroundColor = color
    }
}

extension UIView {
    public func makeRound() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    public func makeShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
        layer.masksToBounds = false
    }
}
