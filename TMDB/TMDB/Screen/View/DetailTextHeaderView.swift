//
//  DetailTextHeaderView.swift
//  TMDB
//
//  Created by heerucan on 2022/08/07.
//

import UIKit

class DetailTextHeaderView: UIView {

    // MARK: - Property
        
    var headerList = ["OverView", "Cast", "Crew"]
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    let lineView = UIView()
    let titleLabel = UILabel()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ConfigureUI
    
    func configureUI() {
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.textColor = .lightGray
        lineView.backgroundColor = .systemGray5
        backgroundColor = .white
    }
    
    func setupLayout() {
        addSubview(titleLabel)
        addSubview(lineView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
       
        lineView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1).isActive = true
        lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}
