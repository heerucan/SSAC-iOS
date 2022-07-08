//
//  PracticeViewController.swift
//  Netflix
//
//  Created by heerucan on 2022/07/05.
//

import UIKit

class PracticeViewController: UIViewController {

    // 초기화는 안했고, 선언만 했다!
    // 너가 필요한 시점에 초기화만 해줘!
    // var인 이유는 추후에 코드로 변경을 줄 것임
    @IBOutlet weak var posterImageView: UIImageView!
      
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var movieButton: UIButton!
    
    // 뷰 컨트롤러의 생명주기 종류 중 하나
    // option command 방향키 -> 접힘
    override func viewDidLoad() {
        super.viewDidLoad()
        posterImageView.image = UIImage(named: "movie\(Int.random(in: 1...5))")
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = posterImageView.frame.width / 2
        
        movieTitleLabel.text = "택시운전사"
        movieTitleLabel.backgroundColor = .yellow
        movieTitleLabel.textColor = .darkGray
        movieTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        movieTitleLabel.textAlignment = .center
        
        movieButton.setTitle("포스터 바꾸기", for: .normal)
    }

    @IBAction func movieButtonClicked(_ sender: UIButton) {
        posterImageView.image = UIImage(named: "movie\(Int.random(in: 1...5))")
    }
}
