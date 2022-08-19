//
//  WriteView.swift
//  Diary
//
//  Created by heerucan on 2022/08/19.
//

import UIKit

class WriteView: BaseView {
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleTextField: BlackRadiusTextField = {
        let textField = BlackRadiusTextField()
        textField.placeholder = "제목을 입력해주세요"
        return textField
    }()
    
    let dateTextField: BlackRadiusTextField = {
        let textField = BlackRadiusTextField()
        textField.placeholder = "날짜를 입력해주세요"
        return textField
    }()
    
    let contentTextView: UITextView = {
        let view = UITextView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        self.addSubviews([photoImageView,
                          titleTextField,
                          dateTextField,
                          contentTextView])
    }
    
    override func configureLayout() {
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(self).multipliedBy(0.3)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
            make.leading.equalTo(photoImageView.snp.leading)
            make.trailing.equalTo(photoImageView.snp.trailing)
            make.height.equalTo(50)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.leading.equalTo(photoImageView.snp.leading)
            make.trailing.equalTo(photoImageView.snp.trailing)
            make.height.equalTo(50)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).offset(20)
            make.leading.equalTo(photoImageView.snp.leading)
            make.trailing.equalTo(photoImageView.snp.trailing)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
