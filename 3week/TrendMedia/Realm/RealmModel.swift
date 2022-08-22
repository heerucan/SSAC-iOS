//
//  RealmModel.swift
//  TrendMedia
//
//  Created by heerucan on 2022/08/23.
//

import Foundation

import RealmSwift

// MARK: - ShoppingList

class ShoppingList: Object {
    @Persisted var check: Bool
    @Persisted var list: String
    @Persisted var favorite: Bool
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(list: String) {
        self.init()
        self.check = false
        self.list = list
        self.favorite = false
    }
}
