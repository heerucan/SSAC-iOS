import UIKit

var greeting = "Hello, playground"

class Guild {
    var name: String
    weak var owner: User? // 길드장은 누구?
    init(name: String) {
        self.name = name
        print("Guild Init")
    }
    
    deinit {
        print("Guild Deinit")
    }
}

class User {
    var name: String
    var guild: Guild? // 고래밥이 새싹이라는 길드에 있다면?
    
    init(name: String) {
        self.name = name
        print("User Init")
    }
    
    deinit {
        print("User Deinit")
    }
}

var user: User? = User(name: "후리") // User: RC 1
var guild: Guild? = Guild(name: "새싹") // Guild: RC 1


user?.guild = guild // 후리라는 유저가 새싹이라는 길드에 들어감 Guild: RC 2
guild?.owner = user // 후리는 새싹 길드장이 됨 User: RC 1. owner에 대한 RC가 증가되지 않음

// 순환참조 중인 요소를 먼저 nil로 바꾼다. - 인스턴스의 참조관계 먼저 해제
//guild?.owner = nil // User: RC 2 -> 1
//user?.guild = nil // Guild: RC 2 -> 1
user = nil // User: RC 0

guild?.owner // 메모리 주소는 남아있음

//guild = nil // Guild: RC 0
//user = nil // User: RC 0
