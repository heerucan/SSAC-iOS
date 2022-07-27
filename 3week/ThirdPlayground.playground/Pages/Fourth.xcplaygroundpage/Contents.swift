//: [Previous](@previous)

import Foundation

// 인스턴스 메소드 / 타입 메소드

struct Coffee {
    static var name = "아메리카노"
    static var shot = 2
    var price = 4900
    
    // 구조체 내에 있는 프로퍼티 값을 변경하려고 하면 mutating 키워드를 붙여줘야 한다.
    mutating func plusShot() {
//        shot += 1
        price += 300
    }
    
    static func minusShot() {
        shot -= 1
    }
}

// 인스턴스 메소드는 오버라이드를 통해 사용가능

//class Latte: Coffee {
//    // 타입 메소드를 오버라이드를 해서 사용하려면 class 키워드를 사용하기 static 대신!
//    override class func minusShot() {
//
//    }
//}
