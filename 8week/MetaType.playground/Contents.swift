import UIKit


struct User {
    let name = "후리" // 인스턴스 프로퍼티
    static let originalName = "Ruhee" // 타입프로퍼티
}

let user = User() // 인스턴스 name 호출 가능 but, originalName 호출X
user.name
user.self.name


User.originalName
User.self.originalName


let intValue: Int = 9.self
let intType: Int.Type = Int.self


/*
 Swift Error Handling
 - try!
 - 안정적인 것은 do try catch
 */

// 들어온 값이 숫자면 true 아니면 fasle
//func validateUserInput(text: String) -> Bool {
//    guard !(text.isEmpty) else {
//        print("빈값")
//        return false
//    }
//
//    guard Int(text) != nil else {
//        print("숫자가 아닙니다")
//        return false
//    }
//    return true
//}



// 이렇게 HTTP StatusCode를 붙여줄 수 있다.

enum ValidationError: Int, Error {
    case emptyString = 401
    case isNotInt = 400
    case success = 200
    case forbidden = 403
    case notFound = 404
    case serverError = 500
}

/* 반환값 앞에 오류를 던진다는 것 : 문제가 생기는 지점을 밖에 던진다는 것, 그리고 문제가 생기는 요소가 많아서 s를 붙여서 throws
 
 => 문제가 생기면 throw가 튀어나옴
 
 */

func validateUserInput(text: String) throws -> Bool {
    // 입력한 값이 비었는지
    guard !(text.isEmpty) else {
        throw ValidationError.emptyString
    }
    
    // 입력한 값이 숫자인지 아닌지
    guard Int(text) != nil else {
        throw ValidationError.isNotInt
    }
    return true
}



do { // do가 옳은 경우, catch가 에러처리
    
    // validateUserInput를 될 때까지 시도를 해보고, 그래도 안되면 catch를 실행하렴
    // try에 옵셔널이 붙을 수 있고, try! 강제 언래핑을 할 수도 있다.
    let result = try validateUserInput(text: "202020220201")
    print(result)
    
    // try validateUserInput(text: "202020220201") 이렇게도 작성가능하다.
    
} catch ValidationError.emptyString {
    print("Empty")
} catch ValidationError.isNotInt {
    print("ISNOTINT")
} catch {
    print("ERROR")
}


//try validateUserInput(text: "")


/*
 do ~ try ~ catch를 통해 realm을 안전하게 써줄 수 있다.
 그리고 try는 항상 오류를 던지는 throw와 함께 구성되어 있다.
 - Diary 앱에서
 제목을 잘못 입력하거나, 내용을 잘못 작성하거나 등에 처리해줄 수 있다.
 */

do {
    try validateUserInput(text: "202020220201")
    print("SUCCESS")
    
} catch ValidationError.emptyString {
    print("Empty")
    
} catch ValidationError.isNotInt {
    print("ISNOTINT")
    
} catch {
    print("ERROR")
    
}


func checkDefer() {
    print("1. 어디서부터 실행되는지 한 번 보자고?")
    defer { print("defer 하나 ")}
    defer { print("defer 둘 ")}
    defer { print("defer 셋 ")}
    print("2. 디퍼 없는 실행 구문 끝임")
}

checkDefer()
