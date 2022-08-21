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


/*
 Generic
 - 타입에 유연하게 대응하기 위한 요소이다.
 - Type Parameter: 플레이스 홀더 같은 역할, 어떤 타입인지 타입의 종류는 알려주지 않음, 특정한 타입 하나라는 건 알 수 있음
 - 한 가지 종류가 들어가는데 어떤 타입이 들어갈 지는 모른다.
 - 제네릭으로 이루어진 함수 사용 시 T에 들어갈 타입은 모두 같아야 한다.
 - UpperCased ex. <T> <K> <U>
 - Type Constraints : 클래스/프로토콜 제약을 걸어줘야 한다.
 
 */

// 예시1
func configureBorderLabel(_ view: UILabel) {
    view.backgroundColor = .clear
    view.clipsToBounds = true
    view.layer.cornerRadius = 8
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 1
}

func configureBorderButton(_ view: UIButton) {
    view.backgroundColor = .clear
    view.clipsToBounds = true
    view.layer.cornerRadius = 8
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 1
}

func configureBorderTextField(_ view: UITextField) {
    view.backgroundColor = .clear
    view.clipsToBounds = true
    view.layer.cornerRadius = 8
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 1
}

func configureBorder<T: UIView>(_ view: T) {
    view.backgroundColor = .clear
    view.clipsToBounds = true
    view.layer.cornerRadius = 8
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 1
}

let img = UIImageView()
let label = UILabel()
configureBorder(img)
configureBorder(label)


// 예시2
struct DummyData<T, U> {
    var mainContents: T
    var subContents: U
}

let cast = DummyData(mainContents: "헤어몬", subContents: "주인공역")
let phoneNumber = DummyData(mainContents: "고래", subContents: 01042132366)
let todo = DummyData(mainContents: "밥먹기", subContents: false)


//let data = DummyData(name: "abc")
//let intData = DummyData(name: 3)
//let boolData = DummyData(name: true)


// 예시3

func total(a: [Int]) -> Int {
    return a.reduce(0, +)
}

total(a: [1,2,3,4,5,6,7,8,9])

// 원래는 타입이 Int로 지정되어 있어서 Double, Float도 써주고 싶다면 각각 메소드를 만들어야 한다.
func total(a: [Double]) -> Double {
    return a.reduce(0, +)
}
func total(a: [Float]) -> Float {
    return a.reduce(0, +)
}

total(a: [4.5, 7.7, 8.9])

// 그래서 generic으로 만들어주는 것


func total<T: Numeric>(a: [T]) -> T {
    return a.reduce(.zero, +)
}

func equal<T: Equatable>(a: T, b: T) -> Bool {
    return a == b
}

print(equal(a: 3, b: 4))

// 예시4

class SampleViewController: UIViewController {
    func transitionViewController<T: UIViewController>(sb: String, vc: T) {
        let sb = UIStoryboard(name: sb, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: String(describing: vc)) as! T
        self.present(vc, animated: true)
    }
}



// Equatable

class Animal: Equatable {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    static func == (lhs: Animal, rhs: Animal) -> Bool {
        return lhs.name == rhs.name
    }
}

let one = Animal(name: "고양이")
let two = Animal(name: "고양이")

one.name == two.name


// 변수에 대한 위치를 바꿔주는 기능

var fruit1 = "사과"
var fruit2 = "바나나"
swap(&fruit1, &fruit2) // & => inout parameter
print(fruit1, fruit2)

// 원래 a는 상수인데 바꾸려면 inout 형태로 불러줘야 한다.
func swapToInts(a: inout Int, b: inout Int) {
    let tempA = a
    a = b // a에는 b를 넣어서 보여주고
    b = tempA // b에는 tempA값을 넣어서 보여주는데 tempA는 a값임
}

//swapToInts(a: &<#T##Int#>, b: &<#T##Int#>)

func swapToSomething<T>(a: inout T, b: inout T) {
    let tempA = a
    a = b // a에는 b를 넣어서 보여주고
    b = tempA // b에는 tempA값을 넣어서 보여주는데 tempA는 a값임
}

swapToSomething(a: &fruit1, b: &fruit2)
print(fruit1, fruit2)
