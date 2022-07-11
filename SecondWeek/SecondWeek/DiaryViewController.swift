//
//  DiaryViewController.swift
//  SecondWeek
//
//  Created by heerucan on 2022/07/11.
//

import UIKit

class DiaryViewController: UIViewController {
    
    var countList = [0, 0, 0,
                 0, 0, 0,
                 0, 0, 0]
    
    var emotionList = ["행복해", "사랑해", "좋아해",
                       "당황해", "속상해", "우울해",
                       "심심해", "찝찝해", "억울해"]

    @IBOutlet var labelList: [UILabel]!
    @IBOutlet var buttonList: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func clickedEmotionButton(_ sender: UIButton) {
        for i in 0...buttonList.count-1 {
            switch sender {
            case buttonList[i]:
                countList[i] += 1
                labelList[i].text = emotionList[i] + " \(countList[i])"
            default: break
            }
        }
    }
}
