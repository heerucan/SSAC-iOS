//
//  ViewController.swift
//  Baemin
//
//  Created by heerucan on 2022/07/08.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func printVC() {
        print("뷰컨의 프린트 메소드")
    }

    func changeBackgroundColor() {
        print("viewController에서 선언해준 함수")
        view.backgroundColor = .blue
    }
}
