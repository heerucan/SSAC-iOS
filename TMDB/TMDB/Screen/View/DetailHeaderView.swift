//
//  DetailHeaderView.swift
//  TMDB
//
//  Created by heerucan on 2022/08/07.
//

import UIKit

class DetailHeaderView: UIView {

    // MARK: - Property
    
    let backImageView = UIImageView()
    let posterImageView = UIImageView()
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
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .white
        backImageView.clipsToBounds = true
        backImageView.contentMode = .scaleAspectFill
        posterImageView.contentMode = .scaleAspectFit
    }
    
    func setupLayout() {
        addSubview(backImageView)
        backImageView.addSubview(titleLabel)
        backImageView.addSubview(posterImageView)
        
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        backImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: backImageView.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: backImageView.leadingAnchor, constant: 20).isActive = true
        
        posterImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        posterImageView.leadingAnchor.constraint(equalTo: backImageView.leadingAnchor, constant: 20).isActive = true
        posterImageView.widthAnchor.constraint(equalToConstant: 65).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: 95).isActive = true
    }
}
