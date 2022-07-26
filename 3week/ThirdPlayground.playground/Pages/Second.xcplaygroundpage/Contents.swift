//: [Previous](@previous)

import UIKit
import Darwin

enum DrinkSize {
    case short, tall, grande, venti
}

class DrinkClass {
    let name: String
    var count: Int
    var size: DrinkSize
    
    // 클래스는 초기화 구문이 필요하다. > 상속에 이유가 있지 않을까?
    // 부모 클래스도 초기화가 되어 있어야 상속을 받을 수 있으니까
    // 반면에 struct는 상속이 안되니까..
    init(name: String, count: Int, size: DrinkSize) {
        self.name = name
        self.count = count
        self.size = size
    }
}

struct DrinkStruct {
    let name: String
    var count: Int
    var size: DrinkSize
}

let drinkClass = DrinkClass(name: "스무디", count: 1, size: .grande)
drinkClass.count = 5
drinkClass.size = .tall

print(drinkClass.name, drinkClass.count, drinkClass.size)

// name은 상수로 선언해서 변경을 못하지만 나머지는 값을 변경 가능하다.
// 근데 drinkClass는 let인데 왜 값을 변경해줄 수 있을까?
// ㄴ 왜냐하면 클래스는 주소 공간만 서로 공유하고 실제값이 있는 곳은 서로 다르기 때문(참조타입)


let drinkStruct = DrinkStruct(name: "스무디", count: 1, size: .grande)
//drinkStruct.count = 10
//drinkStruct.size = .grande

print(drinkStruct.name, drinkClass.count, drinkClass.size)

// 근데 struct는 let인 경우에 오류가 발생한다. 왜일까?
// ㄴ 왜냐하면 구조체는 값이 저장되는 공간 자체를 서로 공유하기 때문에 하나가 바뀌면 아예 다 바뀜(값타입)



// 영화 타이틀, 러닝타임, 영상/화질좋은포스터 => 필요한 시점에 초기화를 할 수 없을까?


struct Poster {
    // 구조체를 인스턴스로 생성을 해야만, 그 인스턴스를 통해서 Image 프로퍼티에 접근할 수 있다.
    var image: UIImage = UIImage(named: "star") ?? UIImage()
    
    // init 초기화 구문을 작성할 수 있는 이유?
    // 멤버와이즈 이니셜라이저를 갖고 있지만, 추가적인 구현도 가능하기 때문에 아래 init 초기화 구문을 작성할 수 있다.
    init() { // 작성하지 않아도 되는데 초기화되는지 궁금해서 쓴 것임
        print("Poster initialized")
    }
    
    // 필요에 따라 초기화 구문을 여러 가지로 만들어서 사용할 수 있다
    // 메서드 오버로딩 특성을 활용해 하나의 초기화 구문인데 여러 구문처럼 쓸 수도 있다
    init(defaultImage: UIImage) {
        self.image = defaultImage
    }
    
    init(customImage: UIImage) {
        self.image = customImage
    }
}

// 3개의 인스턴스를 만들었음 - 인스턴스마다 image 프로퍼티가 다른 값을 가질 수 있는가 - 그렇다!
// 왜냐하면 구조체라서! 값타입이기에
var one = Poster()
var two = Poster()
var three = Poster()


struct MediaInfo {
    var mediaTitle: String
    var mediaRuntime: Int
    lazy var mediaPoster: Poster = Poster() // 지연저장 프로퍼티
}

var media = MediaInfo(mediaTitle: "오징어게임", mediaRuntime: 123)

// lazy var는 언제 동작되나? -> 필요한 시점에 사용을 할 때 메모리에 올라감
// 저장 프로퍼티인데 저장을 지연시키는 것 = 저장 지연 프로퍼티
// 언제 쓰지? -> 옵션적인 상황이 있거나, 초반에 초기화하기 부담스러운 용량이나 시간일 때,

// lazy let은 불가능함
// ㄴ let은 인스턴스가 생성되기 전에 값을 가지고 있어야 함 -> 메모리에 올라갈 때
// ㄴ 근데 lazy는 값을 갖고 있음 안돼! 실제로 호출되어 사용되기 전까지는 nil인 상태로 유지되니까!
media.mediaPoster


// 타입 프로퍼티
struct User {
    static let name = "고래밥"
    static let age = 33 // 저장 타입 프로퍼티
}

User.name // 호출하는 시점에 메모리에 올라간다. -> 호출을 하지 않으면 메모리에 올라가지 않음
// ㄴ. 이건 lazy 지연 저장 프로퍼티와 동작 방식이 항상 같아서 lazy 키워드를 굳이 쓰지 않아도 됨

