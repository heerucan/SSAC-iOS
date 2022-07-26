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
    var nickname: String
    var weight: Double
    var height: Double
    
    // 이아이들을 static으로 쓰고 싶으면 연산 프로퍼티에 사용한 인스턴스 프로퍼티도 타입프로퍼티로 써야 됨
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

let food = FoodRestaurant()

print(food.nowOrder)

food.totalOrderCount += 5
food.totalOrderCount += 20


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


// 열거형
enum ViewType {
    case start
    case change
}
