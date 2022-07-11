//
//  ViewController.swift
//  SecondWeek
//
//  Created by heerucan on 2022/07/11.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var greenView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        greenView.layer.cornerRadius = 20
        greenView.clipsToBounds = false
        
        // 특정 모서리에만 cornerRadius를 주고 싶을 때
        greenView.layer.maskedCorners = [.layerMinXMinYCorner]
        
        // false로 설정되어 있으면
        
        // true로 되어 있으면 바깥 요소가 다 날아간다고 보면 되기 때문에 shadow가 불가능
        // cornderRadius와 Shadow는 병행될 수 없음
        
        // 그러면 둥글게 되어 있는 상태 + shadow가 불가능한가?
        // -> 뷰 객체 2개를 겹쳐서 하나는 clipsToBound, 하나는 shadow를 주면 해결됨
        
        
        // 원으로 만드는 방법? -> 그 뷰의 반지름으로 값을 줘야 함
    }
    
    @IBAction func testTextField(_ sender: Any) {
        print("??")
    }
    
    @IBAction func testSlider(_ sender: Any) {
    }
    
    @IBAction func testButton(_ sender: Any) {
    }
    
    @IBAction func testSwitch(_ sender: Any) {
    }
    
}

