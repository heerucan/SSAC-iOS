//
//  UITextField+Extension.swift
//  TrendMedia
//
//  Created by heerucan on 2022/07/19.
//

import UIKit

extension UITextField {
    
    // 저장 프로퍼티는 익스텐션에 사용할 수 없다.
    // 예를 들어,
    // let placeholder = "이메일을 입력해주세요"
    // 선언이 되고 초기화가 되는 것들은 메모리에 미리 올라가서 등록이 되어야 하는 상태여야 하기 때문에
    // extension은 등록이 아니기 때문에 쓸 수 없다.
    
    func borderColor() {
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.borderWidth = 2
        self.borderStyle = .none
    }
}

