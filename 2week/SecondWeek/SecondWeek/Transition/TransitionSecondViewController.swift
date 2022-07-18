//
//  TransitionSecondViewController.swift
//  SecondWeek
//
//  Created by heerucan on 2022/07/15.
//

import UIKit

enum UserDefaultsKey: String {
    case emotionCount
}

class TransitionSecondViewController: UIViewController {
    
    var currentValue = 0

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var mottoTextView: UITextView!
    
    /*
     1. 앱을 켜면 데이터를 가지고 와서 텍뷰에 보여줘야 함
     2. 바뀐 데이터를 저장해줘야 함
     3. UserDefaults
     근데 UserDefaults는 앱을 삭제하면 데이터가 날아감 주의!
     */
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("=============TransitionSecondViewController", #function)
        
        if UserDefaults.standard.string(forKey: "nickname") != nil {
            mottoTextView.text = UserDefaults.standard.string(forKey: "nickname")
        } else {
            mottoTextView.text = "닉네임이 없어서 대신 저장해줌~"
        }
                
//        print(UserDefaults.standard.string(forKey: "nickname"))
//        print(UserDefaults.standard.integer(forKey: "age"))
//        print(UserDefaults.standard.bool(forKey: "inapp"))
        
        countLabel.text = "\(UserDefaults.standard.integer(forKey: UserDefaultsKey.emotionCount.rawValue))"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("TransitionSecondViewController", #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("TransitionSecondViewController", #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("TransitionSecondViewController", #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("TransitionSecondViewController", #function)
    }
    
    // MARK: - About Sandbox
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        UserDefaults.standard.set(mottoTextView.text, forKey: "nickname")
        
        print(#function)
    }
    
    @IBAction func addEmotionButtonClicked(_ sender: Any) {
        // 기존 데이터 값 가져오기
        let currentValue = UserDefaults.standard.integer(forKey: UserDefaultsKey.emotionCount.rawValue)
        
        // 감정 +1
        let updatevalue = currentValue + 1
        
        // 새로운 값 저장
        UserDefaults.standard.set(updatevalue, forKey: UserDefaultsKey.emotionCount.rawValue)
        
        // 라벨에 새로운 내용 보여주기
        // currentValue를 넣어주면 이전 데이터이기 때문에 넣어주면 안된다.
        countLabel.text = "\(UserDefaults.standard.set(updatevalue, forKey: UserDefaultsKey.emotionCount.rawValue))"
        
        // 특정 키를 지우겠다.
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.emotionCount.rawValue)
        
        // 전체 다 삭제
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.emotionCount.rawValue)
    }
}
