//: [Previous](@previous)

import Foundation

class User {
    var nickname = "Ruhee"
    
    lazy var introduce = { [weak self] in // self RC 안올라가게 약한참조하겠다
//        guard let self = self else { return }
        return "저는 \(self?.nickname)입니다."
    }
    
    init() {
        print("User Init")
    }
    
    deinit {
        print("User Deinit")
    }
}

var user: User? = User()
user?.introduce // RC +1
user = nil


func myClosure() {
    
    var number = 0
    print("1:", number)
    
    
    let closure: () -> Void = { [number] in
        print("closure:", number)
    }
    
    closure()

    number = 100
    print("2:", number)
    
    closure()
}

myClosure()
