//
//  PracticeViewController.swift
//  SecondWeek
//
//  Created by heerucan on 2022/07/12.
//

import UIKit

class PracticeViewController: UIViewController {

    @IBOutlet weak var emotionFirstLabel: UILabel!
    
    @IBOutlet weak var emotionSecondLabel: UILabel!
    
    var emotionFirst = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func emotionFirstButtonClicked(_ sender: UIButton) {
        
        print(sender.tag, sender.currentImage, sender.currentTitle)
        
        emotionFirst += 1
        emotionFirstLabel.text = "\(emotionFirst)"
    }
}
