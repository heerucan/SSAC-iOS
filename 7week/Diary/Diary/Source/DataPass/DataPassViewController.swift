//
//  DataPassViewController.swift
//  Diary
//
//  Created by heerucan on 2022/08/18.
//

import UIKit

import SnapKit

final class DataPassViewController: UIViewController {

    // MARK: - Property
    
    private lazy var nameButton: UIButton = {
        let button = UIButton()
        button.setTitle("닉네임", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(touchupNameButton), for: .touchUpInside)
        return button
    }()
    
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
        view.addSubview(nameButton)
        
        nameButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(200)
        }
    }
    
    // MARK: - Custom Method
    
    
    // MARK: - @objc
    
    @objc func touchupNameButton() {
        // 여기에 인스턴스를 이미 만들어뒀으니까 기능구현을 미리 해두고!
        // 작동은 언제시키냐!?! -> 필요한 시점에 시키겠지?! 그건 바로 dismiss할 때!
        let vc = ProfileViewController()
        // 함수 타입이 들어오게 되는 것임
        vc.saveButtonActionHandler = {
            self.nameButton.setTitle(vc.nameTextField.text, for: .normal)
        }
        
        vc.saveButtonActionHandler2 = { name in
            self.nameButton.setTitle(name, for: .normal)
        }
        
        present(vc, animated: true, completion: nil)
    }

}
