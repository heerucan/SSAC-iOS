//
//  ViewController.swift
//  week18
//
//  Created by heerucan on 2022/11/02.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIService.shared.signup(userName: "ruru", email: "ruru@naver.com", password: "22233344")
        
        APIService.shared.login(email: "ruru@naver.com", password: "22233344")
        
        APIService.shared.profile()
    }


}

