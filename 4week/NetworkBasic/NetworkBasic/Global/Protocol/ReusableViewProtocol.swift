//
//  ReusableViewProtocol.swift
//  NetworkBasic
//
//  Created by heerucan on 2022/08/01.
//

import UIKit

protocol ReusableViewProtocol {
    static var identifier: String { get }
}

extension UIViewController: ReusableViewProtocol {
    
    // 연산프로퍼티의 형태가 나오는데 왜냐하면, extension은 저장프로퍼티 불가능
    static var identifier: String {
        // get만 사용하면 get을 생략할 수 있다.
//        get {
//            return String(describing: self)
//        }
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
