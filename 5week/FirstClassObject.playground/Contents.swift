import UIKit

var greeting = "Hello, playground"

// 일급 객체, 클로저
// 클래스의 인스턴스 = 객체
// 스위프트의 특징

/*
 일급 객체
 
 1. 변수나 상수에 함수를 대입할 수 있다.
 
 2. 함수의 인자값(매개변수)으로 함수를 사용할 수 있다.
 
 */


func checkBankInformation(bank: String) -> Bool {
    let bankArray = ["우리", "국민", "신한"]
    return bankArray.contains(bank) ? true : false
}

// 변수나 상수에 함수를 실행해서 반환된 반환값을 대입한 것(따라서 일급객체의 특성은 아님)
let checkResult = checkBankInformation(bank: "우리") // checkResult의 반환타입인 Bool 타입에 해당

print(checkResult)


// (이게 일급 객체의 특성)
// 변수나 상수에 함수 '자체'를 대입할 수 있다.
// 단지 함수만 대입한 것으로, 실행된 상태는 아님
let checkAccount = checkBankInformation

// (String) -> Bool : Function Type이라고 말함 (ex. Tuple)
let tupleExample = (1, 2, "Hello", true)
tupleExample.2


// 함수를 호출을 해줘야 실행이 된다.
checkAccount("신한")



// Function Type : (String) -> String
func hello(username: String) -> String {
    return "저는 \(username)"
}

// Function Type : (String, Int) -> String
func hello(nickname: String, age: Int) -> String {
    return "저는 \(nickname), \(age)살 입니다."
}


// 오버로딩 특성 상 함수를 구분하기 힘든 경우, 타입 어노테이션을 통해서 함수를 구분할 수 있다.
// 그러나 타입 어노테이션만으로 함수를 구분할 수 없는 상황도 있다.
let ageResult: (String, Int) -> String = hello
ageResult("고래밥", 22)



let result: (String) -> String = hello(username:)
result("고래밥")

func hello(nickname: String) -> String {
    return "저는 \(nickname)"
}

let result2 = hello(nickname:) // 함수 표기법
result2("상어밥")



// 2번 특성
// () -> ()
func oddNumber() {
    print("홀수")
}


func evenNumber() {
    print("짝수")
}

evenNumber

func resultNumber(number: Int, odd: () -> (), even: () -> ()) {
    return number.isMultiple(of: 2) ? even() : odd()
}

// 매개변수로 함수를 전달한다.
resultNumber(number: 9, odd: oddNumber, even: evenNumber)

resultNumber(number: 2) {
    print("홀수")
} even: {
    print("짝수")
}

