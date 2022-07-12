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
        labelList[0].text = setUserNickname()
        view.backgroundColor = example().0
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
        
        showAlertController()
    }
    
    func setUserNickname() -> String {
        let nickname = ["고래밥", "칙촉", "꼬깔콘"]
        let select = nickname.randomElement()!
            
        return "저는 \(select)입니다"
    }
    
    func example() -> (UIColor, String, String) {
        let color: [UIColor] = [.yellow, .red, .blue]
        let image: [String] = ["sesac_slime6", "sesac_slime7"]
        
        return (color.randomElement()!, "루희", image.randomElement()!)
    }
    
    func showAlertController() {
        // 1. 흰색 바탕 만들기 : UIAlertController
        
        let alert = UIAlertController(title: "타이틀", message: "메시지가 들어간당~", preferredStyle: .actionSheet)
        
        // 2. 버튼 만들기
        
        let okButton = UIAlertAction(title: "좋아", style: .default, handler: nil)
        let cancelButton = UIAlertAction(title: "싫어", style: .cancel, handler: nil)
        let webButton = UIAlertAction(title: "웹으로 가기", style: .default, handler: nil)
        let shareButton = UIAlertAction(title: "공유하기", style: .destructive, handler: nil)
        
        // 3. 버튼을 하나로 만들기
        
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        alert.addAction(webButton)
        alert.addAction(shareButton)
        
        // 4. 띄워주기
        
        present(alert, animated: true, completion: nil)
    }
}
