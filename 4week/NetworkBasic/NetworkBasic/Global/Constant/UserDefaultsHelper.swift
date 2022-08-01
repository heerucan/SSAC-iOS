//
//  UserDefaultsHelper.swift
//  NetworkBasic
//
//  Created by heerucan on 2022/08/01.
//

import Foundation

class UserDefaultsHelper {
    
    private init() { }
    
    static let standard = UserDefaultsHelper()
    
    let userDefaults = UserDefaults.standard
    
    enum Key: String {
        case nickname, age
    }
    
    var nickname: String? {
        get {
            return userDefaults.string(forKey: Key.nickname.rawValue) ?? "대장"
        }
        set { // 연산 프로퍼티 파라미터
            userDefaults.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    // int는 default값이 0이라서 optional 상관없음
    var age: Int {
        get {
            return userDefaults.integer(forKey: Key.age.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.age.rawValue)
        }
    }
}
