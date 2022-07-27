//: [Previous](@previous)

import Foundation

// 인스턴스 생성 여부와 상관없이 타입 프로퍼티의 값은 하나다!

struct User {
    static var originalname = "진짜이름" // 타입 저장 프로퍼티
    var nickname = "고래밥" // 인스턴스 저장 프로퍼티
}

var user1 = User()
user1.nickname = "올라프"
User.originalname = "ruhee"
print(user1.nickname, User.originalname)

var user2 = User()
print(user2.nickname, User.originalname)

var user3 = User()
print(user3.nickname, User.originalname)

var user4 = User()
print(user4.nickname, User.originalname)

// 타입프로퍼티는 하나만 사용이 가능하고
// 인스턴스 프로퍼티는 여러개 사용이 가능



/*
 연산 프로퍼티 (인스턴스 연산 프로퍼티 / 타입 연산 프로퍼티)
 */

struct BMI {
    var nickname: String {
        willSet(newNickname) {
            // newValue 대신 newNickname을 사용해도 가능
            print("유저 닉네임이 \(nickname)에서 \(newNickname)로 변경될 예정")
        }
        didSet {
            print("유저 닉네임이 \(oldValue)에서 \(nickname)로 변경될 예정")
        }
    }
    var weight: Double
    var height: Double
    
    // 이 아이들을 static으로 쓰고 싶으면 연산 프로퍼티에 사용한 인스턴스 프로퍼티도 타입프로퍼티로 써야 됨
    // 저장 프로퍼티는 메모리 o, 연산 프로퍼티는 저장 프로퍼티를 활용해서 원하는 값을 반환하는 용도로 주로 사용
    var BMIResult: String {
        
        // get은 읽기 전용 프로퍼티이지만 어떤 내용이 들어오냐에 따라 값이 달라지기 때문에 var를 사용한다.
        get {
            let bmiValue = (weight * weight) / height
            let bmiStatus = bmiValue < 18.5 ? "저제충" : "정상 이상"
            return "\(nickname)님의 BMI 지수는 \(bmiValue)로 \(bmiStatus)입니다!"
        }
        set {
            nickname = newValue
        }
    }
}


// 프로퍼티에 접근하려면 인스턴스를 통해서만 접근이 가능함
var bmi = BMI(nickname: "고래밥", weight: 50, height: 100)

let bmiValue = (bmi.weight * bmi.weight) / bmi.height
let bmiStatus = bmiValue < 18.5 ? "저체중" : "정상 이상"
let result = "\(bmi.nickname)님의 BMI 지수는 \(bmiValue)로 \(bmiStatus)입니다!"
print(result)

// 근데 연산 프로퍼티가 있다면 구조체 내에서 알아서 계산을 하기 때문에
print(bmi.BMIResult)


bmi.BMIResult = "올라프" // set
print(bmi.BMIResult)

// 어떤 경우에 연산 프로퍼티를 사용해야 하는지는 고민할 것





class FoodRestaurant {
    let name = "비비큐"
    var totalOrderCount = 10 // 총 주문건수
    
    var nowOrder: Int {
        get {
            return totalOrderCount * 5000
        }
        set {
            totalOrderCount += newValue // 기본 파라미터가 newValue를 쓴다 -> 애플이 지정해둠
        }
    }
}

let food = FoodRestaurant() // food라는 인스턴스를 하나 만들어서 클래스를 초기화 했음

food.totalOrderCount // 10
print(food.nowOrder) // 10 * 5000 = 50,000 이 나오겠지?

food.totalOrderCount += 10 // 총 주문건수에 10을 더한 것임 = 20 (newValue라는 파라미터)

food.nowOrder // 20 * 5000 = 100,000

food.nowOrder = 5 // set이 동작, Set이 있어야 연산 프로퍼티에 값을 넣어줄 수 있는 것이다!!

food.nowOrder // get이 동작


// set이라는 연산 프로퍼티로 인해 가능
// newValue에 값이 들어오고 get을 통해 값을 가져옴
food.nowOrder = 5
print(food.nowOrder)
food.nowOrder = 20
print(food.nowOrder)
food.nowOrder = 100
print(food.nowOrder)

// 예를 들어, currentTitle의 경우 get만 있어서 값 변경이 안됨


// 열거형은 타입 자체라 인스턴스 생성이 불가능해서 초기화 구문이 없다
// 인스턴스 생성을 통해서 접근할 수 있는 인스턴스 저장 프로퍼티 사용이 불가!

// 열거형은 저장 프로퍼티는 안되는데 연산 프로퍼티가 되는 이유가 뭘까?
// 메모리의 관점 + 열거형이 컴파일 타임에 확정되어야 한다는 것에 기반함 => 인스턴스 연산 프로퍼티는 열거형에서 사용 가능
// 열거형은 빌드하는 순간에 이미 값이 존재하는 것처럼 동작하기 때문에 메모리에 바로 올라감

// 타입 저장 프로퍼티 -> 열거형에서 사용 가능!

enum ViewType {
    case start
    case change
    
    var nickname: String {
        return "aa"
    }
    
    static var title = "시작하기"
}

ViewType.title


// 인스턴스 연산 프로퍼티는 사용하지 않으면 메모리에 올라가지 않고,
// 인스턴스 저장 프로퍼티가 안되는 이유는 인스턴스 생성을 해야 하는데 열거형은 타입 그자체로 초기화 구문이 없기 때문에 인스턴스
// 생성이 불가능하다. 따라서 불가능하다.


// 타입 저장 프로퍼티 , 타입 연산 프로퍼티, 인스턴스 저장 프로퍼티, 인스턴스 연산 프로퍼티



// 7/27

class TypeFoodRestaurant {
    static let name = "비비큐" // 타입 상수 저장 프로퍼티
    static var totalOrderCount = 10 {
        willSet { // 값이 변경되기 직전에 호출
            print("willSet: 총 주문 건수가",totalOrderCount,"에서",newValue,"로 변경될 예정이다.")
        }
        didSet { // 값이 변경되고 난 직후에 호출
            print("didSet: 총 주문 건수가",oldValue,"에서",totalOrderCount,"로 변경되었다.")
        }
    }
    
    static var nowOrder: Int {
        get {
            return totalOrderCount * 5000
        }
        set {
            totalOrderCount += newValue // 기본 파라미터가 newValue를 쓴다 -> 애플이 지정해둠
        }
    }
}

TypeFoodRestaurant.nowOrder
TypeFoodRestaurant.nowOrder = 15
TypeFoodRestaurant.nowOrder

// Property Observer : 저장 프로퍼티에서 주로 사용되고, 저장 프로퍼티 값을 관찰하다가 변경이 될 것 같을 때 또는 변경이 되었을 때 호출됨 - willSet / didSet


struct Ruhee {
    var dream: String {
        willSet {
            print("변경되기 직전 \(dream)->\(newValue)로 변경될 예정이다.")
        }
        didSet {
            print("변경되고 난후 \(oldValue)->\(dream)로 변경되었다")
        }
    }
}

var nowRuhee = Ruhee(dream: "Designer")
print(nowRuhee.dream)
nowRuhee.dream = "iOS Developer"
