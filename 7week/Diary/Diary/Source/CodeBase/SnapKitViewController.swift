//
//  SnapKitViewController.swift
//  Diary
//
//  Created by heerucan on 2022/08/17.
//

import UIKit

import SnapKit

final class SnapKitViewController: UIViewController {

    // MARK: - Property
    
    let photoImageView: UIImageView = {
        print("텍피리")
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.placeholder = "제목을 입력해주세요"
        textField.textAlignment = .center
        textField.font = .boldSystemFont(ofSize: 15)
        return textField
    }()
    
    let dateTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.placeholder = "날짜를 입력해주세요"
        textField.textAlignment = .center
        textField.font = .boldSystemFont(ofSize: 15)
        return textField
    }()
    
    let contentTextView: UITextView = {
        let view = UITextView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("뷰딛로드")
        configureUI()
        configureLayout()
    }
    
    // MARK: - Configure UI & Layout
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    private func configureLayout() {
        view.addSubviews([photoImageView,
                          titleTextField,
                          dateTextField,
                          contentTextView])
        
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
//            make.leadingMargin.equalTo(20)
//            make.trailingMargin.equalTo(-20)
            make.leading.trailing.equalToSuperview().inset(20)
//            make.height.equalTo(100)
            make.height.equalTo(view).multipliedBy(0.3) // view의 높이의 0.3 정도
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
            make.leading.equalTo(photoImageView.snp.leading)
            make.trailing.equalTo(photoImageView.snp.trailing)
//            make.leadingMargin.equalTo(20)
//            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.leading.equalTo(photoImageView.snp.leading)
            make.trailing.equalTo(photoImageView.snp.trailing)
//            make.leadingMargin.equalTo(20)
//            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).offset(20)
//            make.leadingMargin.equalTo(20)
//            make.trailingMargin.equalTo(-20)
            make.leading.equalTo(photoImageView.snp.leading)
            make.trailing.equalTo(photoImageView.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
   
    
    // MARK: - Custom Method
    
    
    // MARK: - @objc

}

extension UIView {
    func addSubviews(_ myView: [UIView]) {
        myView.forEach { self.addSubview($0)}
    }
}
