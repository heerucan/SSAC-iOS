//
//  BlackRadiusTextField.swift
//  Diary
//
//  Created by heerucan on 2022/08/19.
//

import UIKit

class BlackRadiusTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTextField() {
        backgroundColor = .clear
        textAlignment = .center
        borderStyle = .none
        layer.cornerRadius = 9
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor
        font = .boldSystemFont(ofSize: 15)
    }
}
