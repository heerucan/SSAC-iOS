//
//  Protocol.swift
//  6weekProject
//
//  Created by heerucan on 2022/08/10.
//

import UIKit

protocol ReusableViewProtocol {
    static var identifier: String { get }
}

extension UICollectionViewCell: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
extension UITableViewCell: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
