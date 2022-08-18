import UIKit

/*
 Type Casting
 
 - 형변환 => 타입캐스팅/타입변환
 - 타입캐스팅 : 인스턴스의 타입을 확인하거나 인스턴스 자신의 타입을 다른 타입의 인스턴스인 것처럼 사용할 때 활용되는 개념
 */

let a = 3
let value = String(a) // 초기화 구문을 통해 새롭게 인스턴스를 생성한 것 = 형변환

type(of: a)
type(of: value)


// 예시

class Mobile {
    let name: String
    var introduce: String {
        return "\(name)입니다."
    }
    
    init(name: String) {
        self.name = name
    }
}

class Google: Mobile {
    
}

class Apple: Mobile {
    let wwdc = "WWDC22"
}

let mobile = Mobile(name: "PHONE")
let apple = Apple(name: "APPLE")
let google = Google(name: "GOOGLE")


// is : 어떤 클래스의 인스턴스 타입, 데이터 타입인지 확인하기
// ex. Local Notificaiton

mobile is Mobile
// 상속을 받아서 true는 아님
mobile is Apple
mobile is Google

apple is Mobile
apple is Apple
apple is Google

// Type Cast Operator: as(업캐스팅) / as? / as! (다운캐스팅)
// 업캐스팅 : 부모클래스 타입인 걸 알 경우, 항상 성공하는 걸 알 경우

let iphone: Mobile = Apple(name: "APPLE")
iphone.introduce // Mobile 타입이라서 Mobile 연산 프로퍼티를 쓸 수 있다.

let iphone2 = Apple(name: "APPLE") // type 지정을 안하면 wwdc에 접근이 가능
iphone2.wwdc


// as? 옵셔널 반환 타입 => 안전함 | 실패할 경우 nil 반환
// as! 옵셔널 반환 X => 실패할 경우, 무조건 런타임 오류 발생
if let value = iphone as? Apple {
    print(value.wwdc)
} else {
    print("타입 캐스팅 실패")
}

// iphone as! Google -> 런타임 오류 발생


/*
 Any, Anyobject
 - Any : 모든 타입에 대한 인스턴스를 다 담을 수 있음
 - AnyObject : 클래스의 인스턴스만 담을 수 있음
 
 그리고 컴파일 시점에선 어떤 타입인지 알 수 없고, 런타임 시점에 타입이 결정
 */

var somethings: [Any] = []
somethings.append(0)
somethings.append(true)
somethings.append("ruhee")
somethings.append(mobile) // 이것만 AnyObject에 해당

print(somethings[1])

let example = somethings[1]

if let element = example as? Bool {
    print(element)
} else {
    print("Bool 아님")
}

if let element = example as? String {
    print(element.count)
} else {
    print("String 아님")
}

