//
//  BaseView.swift
//  Diary
//
//  Created by heerucan on 2022/08/19.
//

import UIKit

import SnapKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() { }
    
    func configureLayout() { }
}


