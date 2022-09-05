//: [Previous](@previous)

import Foundation

protocol MyDelegate: Main { // 클래스에서만 사용할 수 있다고 선언해줘야 함 - 왜냐면 구조체에서 사용안한다고 알려주고, 클래스 제약을 걸어서 참조타입에서만 쓸 수 있다는 걸 알아야 weak ARC 관리가 가능하니까
    
    func sendData(_ data: String)
}

class Main: MyDelegate {
    
    lazy var detail: Detail = {
        let view = Detail()
        view.delegate = self
        return view
    }()
    
    func sendData(_ data: String) {
        print(data, "를 전달받음요~")
    }
    
    init() {
        print("Main Init")
    }
    
    deinit {
        print("Main Deinit")
    }
}

class Detail {
    
    weak var delegate: MyDelegate? // 클래스의 인스턴스가 들어올 수 있음.
    
    func dismiss() {
        delegate?.sendData("안녕")
    }
    
    init() {
        print("Detail Init")
    }
    
    deinit {
        print("Detail Deinit")
    }
}

var main: Main? = Main() // Main RC +1
main?.detail // Main RC +2 => detail의 view.delegate = slef(Main)으로 참조가 되는 상황
main = nil // RC 0
