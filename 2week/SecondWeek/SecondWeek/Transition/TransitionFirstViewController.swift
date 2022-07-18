//
//  TransitionFirstViewController.swift
//  SecondWeek
//
//  Created by heerucan on 2022/07/15.
//

import UIKit

class TransitionFirstViewController: UIViewController {
    
    // 1.
    @IBAction func unwindTransitionFirstVC(jackSegue: UIStoryboardSegue) {
        
    }
    
    @IBOutlet weak var randomNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("==============", #function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        randomNumberLabel.text = "\(Int.random(in: 1...100))"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
        print("저장완료")
    }

}
