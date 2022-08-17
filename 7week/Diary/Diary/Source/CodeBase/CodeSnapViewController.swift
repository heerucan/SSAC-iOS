//
//  CodeSnapViewController.swift
//  Diary
//
//  Created by heerucan on 2022/08/17.
//

import UIKit

import SnapKit

class CodeSnapViewController: UIViewController {
    
    // MARK: - Property
    
    let greenView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    let redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let yellowView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    let containerView = UIStackView()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
    }
    
    // MARK: - Configure UI & Layout
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    private func configureLayout() {
        view.addSubviews([redView, greenView])
        greenView.addSubview(yellowView)
        
        redView.snp.makeConstraints { make in
            make.width.height.equalTo(200)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(100)
            make.centerX.equalTo(view)
        }
        
        greenView.snp.makeConstraints { make in
            make.edges.equalTo(redView).offset(50)
        }
        
        yellowView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(30)
        }
    }
    
    // MARK: - Custom Method
    
    
    // MARK: - @objc
}
