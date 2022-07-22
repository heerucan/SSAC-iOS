import UIKit

var greeting = "Hello, playground"


// 옵셔널 바인딩

var shoplist: String? = "신발 사기"
var shoplist2: String? = "모니터 사기"

if shoplist != nil && shoplist2 != nil {
//    print("\(shoplist!) \(shoplist2!) 완료")
} else {
//    print("글자를 입력해주세요")
}

// 2글자 이상을 꼭 입력해야 한다면?

shoplist = nil

if let jack = shoplist,
   let value = shoplist2, (2...6).contains(jack.count) == true {
    print("\(jack) \(value) 완료")
} else {
//    print("글자를 입력해주세요")
}

func optionalBindingFunction() {
    // jack이 닐이면 else 구문을 실행
    guard let jack = shoplist,
          let value = shoplist2,
          (2...6).contains(jack.count) else {
//              print("글자를 입력해주세요")
              return
          }
    
//    print("\(jack), \(value) 완료")
}

// 2. 인스턴스 프로퍼티 vs 타입 프로퍼티

class User { // 값을 가지고 있는 상태에서 만들어줘야 함
    var nickname = "고래밥" // 저장 프로퍼티, 인스턴스 프로퍼티
    // 인스턴스를 만들어서 사용해야 하기 때문에 인스턴스 프로퍼티
    // 인스턴스를 통해서 접근 가능하기 때문에.
    
    // 유저가 갖고 있는 스태틱 변수에 접근가능
    //
    static var staticNickname = "고래밥" // 저장프로퍼티 , 타입 프로퍼티
}

let user = User() // 클래스 초기화, 인스턴스 생성
user.nickname = "칙촉" //
//print(user.nickname)

 
// static member 'red'는 cannot be used instance of type 'UIColor'


let user1 = User()

let user2 = User()

let user3 = User()

User.staticNickname // 호출 시 메모리에 올라감, 인스턴스를 생성한다고 해서 초기화되지 않고, 호출해서 사용할 때 초기화가 된다. 그리고 한 번 올라가면 앱이 꺼질 떄까지 메모리에서 사라지지 않는다.

User.staticNickname = "칙촉"
//print(User.staticNickname)

// 역할 기준 - 저장, 연산, 감시자
// 메모리 기준 - 인스턴스, 타입

// 메서드도 이와 같다.
