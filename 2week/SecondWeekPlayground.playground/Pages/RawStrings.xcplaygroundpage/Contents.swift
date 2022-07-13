import UIKit

var greeting = "Hello, playground"

func setNickname() -> Void {
    print("저는루희입니다")
}

setNickname()

func setNicknameParameter(nickname: String) -> String {
    print("\(nickname)입니다.")
    return "\(nickname)입니다."
}

setNicknameParameter(nickname: "후릐")

func getGameCharacter(name: String, age: Int) -> [String] {
    
    let character = ["루희", "도사", "전사", "변호사"]
    let select = character.randomElement()!
    return [name, select]
}

getGameCharacter(name: "훌이", age: 32)

var numberSet: Set = [2, 4, 6, 8, 10]

var numberSet2: Set = [1, 2, 3, 4, 5]

numberSet.subtract(numberSet2) // 원본을 건드림
numberSet.subtracting(numberSet2) // 원본을 건드리지 않음

var numberArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

//numberArray.shuffle() // 원본을 건드림
//print(numberArray)

numberArray.shuffled() // 원본을 건드리지 않음
print(numberArray)


// 중요!!! Raw Strings

var notice = "\"zoom\" 공지사항이다"

print(notice) // "zoom" 공지사항이다

// -> 문자열 내에서 "를 쓰고 싶으면 \" 로 쓴다.

// 1. 그러면 \" 자체를 문자열로 출력하려면? -> RawString (swift5 ~)
// #을 양 끝에 붙이면 됨

var notice1 = #"\"zoom\" 공지사항"""#
print(notice1) // \"zoom\" 공지사항""

// 2. 줄바꿈 - \n 이걸 쓰면 그대로 이것들이 다 출력됨

var space = #" 온라인 \#n 줄바꿈이 되었는가?"#
print(space)
// 온라인
// 줄바꿈이 되었는가?

// RawString에서는 기존 \(~) 과 같은 문자열 보간법이 먹히지 않기 때문에
// \#(~) 이라고 써줘야 한다.

// 양 사이드에 #는 여러개 써도 되지만 여러개 쓸 경우, 양사이드의 # 개수를 맞춰라.

