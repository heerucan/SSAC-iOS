//
//  ViewPresentableProtocol.swift
//  NetworkBasic
//
//  Created by heerucan on 2022/07/28.
//

import Foundation
import UIKit

/*
 ~~Protocol
 ~~Delegate
 */

// 프로토콜은 규약이지 필요한 요소를 명세만 할 뿐, 실질적인 규현부는 작성하지 않고,
// 실질적인 구현은 프로토콜을 채택, 준수한 타입이 구현한다.
// 클래스는 단일 상속만 가능하지만, 프로토콜을 채택 개수에 제한이 없다.

@objc
protocol ViewPresentableProtocol {
    
    var navigationTitleString: String { get set }
    
    var backgroundColor: UIColor { get }
    
    func configureView()
    @objc optional func configureLabel()
    @objc optional func configureTextField()
}


/*
 ex. 테이블뷰
 */

@objc protocol RuheeTableViewProtocol {
    func numberOfRowsInSection() -> Int
    func cellForRowAt(indexPath: IndexPath) -> UITableViewCell
    @objc optional func didSelectRowAt()
}
