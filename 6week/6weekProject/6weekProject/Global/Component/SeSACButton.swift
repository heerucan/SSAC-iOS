//
//  SeSACButton.swift
//  6weekProject
//
//  Created by heerucan on 2022/08/09.
//

import UIKit

@IBDesignable class SeSACButton: UIButton {

    // 스토리보드 상에서 인스펙터 영역에서 사용할 수 있음
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor: UIColor {
        get { return UIColor( cgColor: layer.borderColor!) }
        set { layer.borderColor = newValue.cgColor }
    }
}
