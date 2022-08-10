//
//  CardView.swift
//  6weekProject
//
//  Created by heerucan on 2022/08/09.
//

import UIKit

/*
 xml Interface Builder
 
 방법 2가지
 1. UIView Custom Class
 2. 파일의 주인 설정 : File's owner > 활용도가 높다
 */

class CardView: UIView {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var contentLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        // 이 Nib 파일의 주인은 self(나)이고, 가장 첫 번째에 위치해 있는 UIView이다.
        let view = UINib(nibName: "CardView", bundle: nil).instantiate(withOwner: self).first as! UIView
        view.frame = bounds // 카드뷰의 크기를 똑같이 맞춰주는 작업
        view.backgroundColor = .clear
        self.addSubview(view)
        
        // 카드뷰를 인터페이스 빌더 기반으로 만들고, 레이아웃도 설정했는데 false가 아닌 true로 나오는 이유는 윗 부분의 UINib~ addSubview 부분이 코드로 추가한 부분이기에
        // true가 나오는 것이다.
        // 따라서, true가 나오는 것은 오토레이아웃 적용이 되는 관점보다 오토리사이징이 내부적으로 constraints 처리가 된다.
        print(view.translatesAutoresizingMaskIntoConstraints)
    }
}
