//
//  SegmentViewController.swift
//  SecondWeek
//
//  Created by heerucan on 2022/07/12.
//

import UIKit

enum MusicType: Int {
    case all = 0
    case korea = 1
    case other = 2
}

class SegmentViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentControlValueChanged(segmentControl)
        studyDateFormatter()
    }
    
    @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl) {
        
//        if segmentControl.selectedSegmentIndex == 0 {
//            resultLabel.text = "첫 번째"
//        } else if segmentControl.selectedSegmentIndex == 1 {
//            resultLabel.text = "두 번째 세그먼트 선택"
//        } else if segmentControl.selectedSegmentIndex == 2 {
//            resultLabel.text = "세 번째 세그먼트 선택"
//        } else {
//            resultLabel.text = "오류"
//        }
        
        if segmentControl.selectedSegmentIndex == MusicType.all.rawValue {
            resultLabel.text = "첫 번째 세그먼트 선택"
        } else if segmentControl.selectedSegmentIndex == MusicType.korea.rawValue {
            resultLabel.text = "두 번째 세그먼트 선택"
        } else if segmentControl.selectedSegmentIndex == MusicType.other.rawValue {
            resultLabel.text = "세 번째 세그먼트 선택"
        } else {
            resultLabel.text = "오류"
        }
    }
    
    // MARK: - DateFormatter
    
    func studyDateFormatter() {
        // DateFormatter : 알아보기 쉬운 날짜 + 시간대
        // yyyy MM dd hh:mm:ss
        
        let format = DateFormatter()
        format.dateFormat = "M월 d일, yy년"
        format.locale = Locale(identifier: "ko-KR")
        // 매개변수를 문자로 받아서 날짜로 바꾸는 것
        let result = format.string(from: .now)
        print(result)
        
        let word = "3월 2일, 19년"
        let dateResult = format.date(from: word)
        
        print(dateResult)
        
        // 근데 locale을 안해주면 영국 표준시 기준으로 나온다.
        
    }
}
