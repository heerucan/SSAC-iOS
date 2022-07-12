//
//  DiaryViewController.swift
//  SecondWeek
//
//  Created by heerucan on 2022/07/11.
//

import UIKit

// MARK: - Emotion

enum Emotion: Int, CaseIterable {
    case happy
    case love
    case like
    case flustered
    case upset
    case depressed
    case bored
    case uncomfortable
    case unfair
    
    var emotion: String {
        switch self {
        case .happy:
            return "행복해"
        case .love:
            return "사랑해"
        case .like:
            return "좋아해"
        case .flustered:
            return "당황해"
        case .upset:
            return "속상해"
        case .depressed:
            return "우울해"
        case .bored:
            return "심심해"
        case .uncomfortable:
            return "찝찝해"
        case .unfair:
            return "억울해"
        }
    }
}

class DiaryViewController: UIViewController {
    
    // MARK: - Property
    
    var countList = [0, 0, 0,
                     0, 0, 0,
                     0, 0, 0]
                
    // MARK: - @IBOutlet
    
    @IBOutlet var labelList: [UILabel]!
    @IBOutlet var buttonList: [UIButton]!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - @IBAction
    
    @IBAction func clickedEmotionButton(_ sender: UIButton) {
        
        for i in Emotion.allCases {
            switch sender {
            case buttonList[i.rawValue]:
                countList[i.rawValue] += 1
                labelList[i.rawValue].text = i.emotion + " \(countList[i.rawValue])"
            default: break
            }
        }        
        
        showAlertController()
    }
    
    
    // MARK: - AlertController
    
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
    
    // MARK: - 반환값
    
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
}
