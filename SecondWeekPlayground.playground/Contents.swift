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
