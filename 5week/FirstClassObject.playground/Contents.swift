import UIKit

var greeting = "Hello, playground"

// 일급 객체, 클로저
// 클래스의 인스턴스 = 객체
// 스위프트의 특징

/*
 일급 객체
 
 1. 변수나 상수에 함수(클로저)를 대입할 수 있다.
 2. 함수의 반환타입으로 함수(클로저)를 사용할 수 있다.
 3. 함수의 인자값(매개변수)으로 함수(클로저)를 사용할 수 있다.
 
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

func currentAccount() -> String { // () -> String
    return "계좌 있음"
}

func noCurrentAccount() -> String { // () -> String
    return "계좌 없음"
}


// 가장 왼쪽에 위치한 -> 를 기준으로 오른쪽에 놓인 모든 타입은 반환값을 의미한다.
func checkBank(bank: String) -> () -> String {
    let bankArray = ["우리", "신한", "국민"]
    return bankArray.contains(bank) ? currentAccount : noCurrentAccount // 함수를 호출하는 것은 아니고 함수를 던져줌
}

let jack = checkBank(bank: "농협")
jack()


// 2-1. Calculate

func plus(a: Int, b: Int) -> Int { // (Int, Int) -> Int
    return a + b
}

func minus(a: Int, b: Int) -> Int { // (Int, Int) -> Int
    return a - b
}

func multiply(a: Int, b: Int) -> Int { // (Int, Int) -> Int
    return a * b
}

func divide(a: Int, b: Int) -> Int { // (Int, Int) -> Int
    return a / b
}



func calculate(operand: String) -> (Int, Int) -> Int {
    
    switch operand {
    case "+": return plus
    case "-": return minus
    case "*": return multiply
    case "/": return divide
    default: return plus
    }
}

calculate(operand: "+")(4, 3)

let resultCalculate = calculate(operand: "-")
resultCalculate(4,1)



// 3번 특성
// () -> ()
func oddNumber() {
    print("홀수")
}


func evenNumber() {
    print("짝수")
}

evenNumber

// 어떤 함수가 들어가던 상관이 없고, 타입만 잘 맞으면 된다.
// 실질적 연산이 인자값에 들어가는 함수에 달려 있어, 중계 역할만 담당하고 있어서 브로커라고 부름.
func resultNumber(number: Int, odd: () -> (), even: () -> ()) {
    return number.isMultiple(of: 2) ? even() : odd()
}

// 매개변수로 함수를 전달한다.
// 의도하지 않은 함수가 들어갈 수 있음. 필요 이상의 함수가 자꾸 생김
resultNumber(number: 9, odd: oddNumber, even: evenNumber)


// 이름 없는 함수 == 익명함수라고 부름 = 클로저
resultNumber(number: 2) {
    print("홀수")
} even: {
    print("짝수")
}





/*
 클로저 : 이름없는 함수
 */

func studyiOS() {
    print("주말에도 공부하기")
}

let studyiOSHarder: () -> () = {
    print("주말에도 공부하기")
}

// in을 기준으로 앞을 클로저 헤더 / 그 뒤를 클로저 바디
// 클로저 헤더 in 클로저 바디
let studyiOSHarder2 = { () -> () in
    print("주말에도 공부하기")
}()

func getStudyWithMe(study: () -> ()) {
    study()
    print(#function)
}

// 코드를 생략하지 않고 클로저 구문 씀. 함수의 매개변수 내에 클로저가 그대로 들어간 형태
// => 인라인 클로저 (Inline Closure)
getStudyWithMe(study: { () -> () in
    print("주말에도 공부하기")
})

// 함수 뒤에 클로저가 실행
// => 트레일링 클로저 (후행 클로저)
getStudyWithMe() { () -> () in
    print("주말에도 공부하기")
}




func randomNumber(result: (Int) -> String) {
    result(Int.random(in: 1...100))
}

// 인라인 클로저 상태임
randomNumber(result: { (number: Int) -> String in
    return "행운의 숫자는 \(number)이다."
})

// 인라인 클로저를 축약하면 후행 클로저 상태가 된다.

// 매개변수가 생략되면 할당되어 있는 내부 상수 $0를 사용할 수 있다.
randomNumber(result: {
    "행운의 숫자는 \($0)이다."
})

randomNumber() {
    "행운의 숫자는 \($0)이다."
}

randomNumber {
    "행운의 숫자는\($0)이다."
}

// 고차함수 : filter map reduce

// for문과 filter 중 어떤 게 더 성능이 좋은지 속도 비교해주는 함수
func processTime(code: () -> ()) {
    let start = CFAbsoluteTimeGetCurrent()
    code()
    let end = CFAbsoluteTimeGetCurrent() - start
    print(end)
}

let student = [2.2, 3.3, 2.1, 4.2, 3.1, 4.3]


processTime {
    var newStudent: [Double] = []

    for student in student {
        if student >= 4.0 {
            newStudent.append(student)
        }
    }
    
    print(newStudent)
}

// ex. 4.0 이상인 학생 고르기


// 학생들을 필터링할 건데 4.0 이상인 사람들을 필터링할 거임
let filterStudent = student.filter { value in
    value >= 4.0
}


processTime {
    let filterStudent2 = student.filter { $0 >= 4.0 } // 클로저 축약 사용

    print(filterStudent2)

}


// 2. map : 기존 요소를 클로저를 통해 원하는 결과값으로 변경
let number = [Int](1...100)
var newNumber: [Int] = []

for number in number {
    newNumber.append(number * 3)
}

print(newNumber)


let mapNumber = number.map { $0 * 3 }
print(mapNumber)


let movieList = [
    "괴물": "박찬욱",
    "기생충": "봉준호",
    "인터스텔라": "크리스토퍼 놀란",
    "인셉션": "크리스토퍼 놀란",
    "옥자": "봉준호"
]

// 특정 감독의 영화만 출력

let movieResult = movieList.filter { $0.value == "봉준호" }
print(movieResult)


// 영화 이름 배열로 변환
let movieResult2 = movieList.filter { $0.value == "봉준호" }.map { $0.key }
print(movieResult2)


// 3. reduce :
let examScore: [Double] = [100, 39, 20, 89, 30, 95, 88]
var totalCount: Double = 0

for score in examScore {
    totalCount += score
}

print(totalCount / 8)

let totalCountUsingReduce = examScore.reduce(0) { return $0 + $1 }
print(totalCountUsingReduce / 8)




// drawingGame : 외부함수, luckyNumber: 내부함수
func drawingGame(item: Int) -> String {
    
    func luckyNumber(number: Int) -> String {
        return "\(number * Int.random(in: 1...10))"
    }
    
    let result = luckyNumber(number: item)
    return result
}

drawingGame(item: 10) // 외부함수의 생명 주기가 끝났다. -> 내부 함수의 생명 주기도 끝났다!


// 내부 함수를 반환하는 외부 함수도 만들 수 있다.
func drawingGame2(item: Int) -> () -> String {
    func luckyNumber() -> String {
        return "\(item * Int.random(in: 1...10))"
    }
    
    return luckyNumber
}

drawingGame2(item: 10)

let numberResult = drawingGame2(item: 10)
numberResult()

// 외부 함수의 생명주기가 끝나도 내부 함수는 동작을 하면서 내부 함수의 item이 살아서 메모리에 남아있는 상황이 발생
// 그러면서 클로저에 의해 내부 함수 주변의 지역변수나 상수도 함께 저장이 됨 -> 값이 캡처되었다고 표현됨
// 이게 캡처리스트인데 -> weak, strong, unowned를 통해 해결

