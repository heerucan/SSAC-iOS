//
//  SubscriptExample.swift
//  week18
//
//  Created by heerucan on 2022/11/03.
//

import Foundation

extension String {
    
    // jack >>>> [1] >>>> a
    
    subscript(idx: Int) -> String? {
        
        // 인덱스는 항상 배열 count보다 1씩 작아서 0..<count
        // idx가 저 범위 내에 없으면 nil 반환
        guard (0..<count).contains(idx) else {
            return nil
        }
        
        // 첫 번째 캐릭터로부터 얼마나 떨어져있냐?를 result로 반환
        let result = index(startIndex, offsetBy: idx)
        return String(self[result])
        
        
    }
}

extension Collection {
    
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ?  self[index] : nil
    }
    
}

struct Phone {
    var numbers = ["12", "34", "56", "78", "910"]
    
    subscript(idx: Int) -> String {
        get {
            return self.numbers[idx]
        }
        
        set {
            self.numbers[idx] = newValue
        }
    }
    
    // print(phone.numbers[2]) 대신에 print(phone.[2])로 변경
}
