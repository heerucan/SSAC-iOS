//
//  CodeViewController.swift
//  Diary
//
//  Created by heerucan on 2022/08/17.
//

import UIKit
/*
 1. 뷰객체 프로퍼티 선언, 클래스의 인스턴스 선언
 2. 명시적으로 루트뷰에 추가
 3. 크기와 위치 및 속성 정의
 Frame 기반 한계(iPhone5)
 AutoResizingMask, AutoLayout 등장!
 NSLayoutConstraints (iOS6부터 등장, 지금까지도 사용)
 */


class CodeViewController: UIViewController {

    // MARK: - Property
    
    let emailTextField = UITextField() // -> Frame based layout
    let passwordTextField = UITextField()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
    }
    
    // MARK: - Configure UI & Layout
    
    private func configureUI() {
        view.backgroundColor = .white
        emailTextField.borderStyle = .line
        emailTextField.backgroundColor = .green
        passwordTextField.borderStyle = .line
        passwordTextField.backgroundColor = .orange
    }
    
    private func configureLayout() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        
        // Frame 기반
//        emailTextField.frame = CGRect(x: 50, y: 50, width: 300, height: 50)
        // 이렇게 계산해서 오토레이아웃하듯이 잡아줄 수도 있긴 함
        emailTextField.frame = CGRect(x: 50, y: 100, width: UIScreen.main.bounds.width - 100, height: 50)
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        // NSLayoutConstraints : 위 기준으로 safearea 기준으로 100만큼 주고 싶다.
        let top = NSLayoutConstraint(item: passwordTextField,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: view.safeAreaLayoutGuide,
                           attribute: .top,
                           multiplier: 1,
                           constant: 120)
        let leading = NSLayoutConstraint(item: passwordTextField,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: emailTextField,
                           attribute: .leading,
                           multiplier: 1,
                           constant: 0)
        let trailing = NSLayoutConstraint(item: passwordTextField,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: emailTextField,
                           attribute: .trailing,
                           multiplier: 1,
                           constant: 0)
        let height = NSLayoutConstraint(item: passwordTextField,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .height,
                           multiplier: 1,
                           constant: 60)
        
        [top, leading, trailing, height].forEach { $0.isActive = true }

    }
    
    // MARK: - Custom Method
    
    
    // MARK: - @objc

}
