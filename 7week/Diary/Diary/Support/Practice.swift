//
//  Practice.swift
//  Diary
//
//  Created by heerucan on 2022/08/19.
//

import Foundation

// required initializer
protocol example {
    init(name: String)
}

class Mobile: example {
    let name: String
    
    required init(name: String) {
        self.name = name
    }
}

class Apple: Mobile {
    let wwdc: String
    
    init(wwdc: String) {
        self.wwdc = wwdc
        super.init(name: "모바일")
    }
    
    required init(name: String) {
        fatalError("init(name:) has not been implemented")
    }
}

let a = Apple(wwdc: "애플")

