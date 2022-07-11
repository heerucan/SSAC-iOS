//
//  LifecycleViewController.swift
//  Baemin
//
//  Created by heerucan on 2022/07/11.
//

import UIKit

class LifecycleViewController: MainViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        changeBackgroundColor()
        printVC()
    }
    
    override func printVC() {
        super.printVC()
    }
    
    
    override func changeBackgroundColor() {
//        super.changeBackgroundColor()
        print("상속받은 함수~ 여기에 새로운 기능 추가해야지~")
        view.backgroundColor = .yellow
    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(true)
    //        print("viewWillAppear")
    //    }
    //
    //    override func viewDidAppear(_ animated: Bool) {
    //        super.viewDidAppear(true)
    //        print("viewDidAppear")
    //    }
    //
    //    override func viewWillDisappear(_ animated: Bool) {
    //        super.viewWillDisappear(true)
    //        print("viewWillDisappear")
    //    }
    //
    //    override func viewDidDisappear(_ animated: Bool) {
    //        super.viewDidDisappear(true)
    //        print("viewDidDisappear")
    //    }

}
