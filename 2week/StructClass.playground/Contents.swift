import UIKit

var greeting = "Hello, playground"

// SuperClass, SubClass, BaseClass

// SuperClass, BaseClass임. 어떤 곳에서도 상속을 받지 않기 때문에 BaseClass임
class Monster {
    var clothes = "Orange + Christmas"
    var power = 5
    var speed = 20
    var experience: Double = 500
    
    func attack() {
        print("Monster공격")
    }
}

// nickname이라는 공간에 고래밥이라는 걸 담아주고 이건 메모리에 올라가게 되는 상태 = 인스턴스
var nickname = "고래밥" // 초기화
var easyMonster = Monster() // 초기화된 상태 (인스턴스라고 말함)

easyMonster.clothes
easyMonster.power
easyMonster.speed

easyMonster.attack()
easyMonster.attack()

// SubClass
class BossMonster: Monster {
    var levelLimit = 500

    func bossAttack() {
        print("BossMonster스페셜 공격!!")
    }
    
    // 부모 클래스의 기능을 재정의할 때
    override func attack() {
        super.attack()
        print("BossMonster오버라이드 공격!!")
    }
}

var finalBoss = BossMonster()
finalBoss.bossAttack()
finalBoss.levelLimit
finalBoss.speed
finalBoss.attack()

// 객체, 클래스의 인스턴스를 객체라고 부른다. / 뷰 객체다라고 할 수 있는 거는 뷰가 클래스로 만들어져서

var name = "고래밥"
var subNickname = name
print(name) // 고래밥
print(subNickname) // 고래밥
 
subNickname = "칙촉"
print(name) // 고래밥
print(subNickname) // 칙촉

var miniMonster = Monster()
miniMonster.attack()

var bossMonster = miniMonster

print(bossMonster.power)

bossMonster.power = 5000

print(miniMonster.power)
print(bossMonster.power) // 원래 5였는데 5000으로 바뀜


// 구조체는 값 타입, 클래스는 참조 타입

// 클래스는 자신의 공간에 메모리 주소만 저장하고, 데이터는 다른 곳에 저장하고 있기 때문이다.

// 7/14
// 변수/상수가 클래스/구조체/열거형 등에 들어가면 프로퍼티라고 바뀌고, 함수는 메소드로 바뀜

class MyMonster {
    var name = "초보몬스터"
    var level = 1
}

let easy = MyMonster()

var hard = easy

print(easy.name, easy.level)
print(hard.name, hard.level)

hard.name = "보스몬스터"
hard.level = 100

// class의 경우 hard값을 변경했더니 easyMonster도 값이 바뀌어버림
// struct의 경우 값이 각자 유지됨
print(easy.name, easy.level)
print(hard.name, hard.level)

var nicknames = "고래밥" // 선언과 초기화를 동시에 함


// 옵셔널로 선언된 프로퍼티는 nil을 가질 수 있는 상황. 그래서 나중에 초기화를 해도 됨
// 옵셔널이 아닌 프로퍼티는 값이 무조건 있어야 함. 그래서 초기화가 필요함
class SecondMonster {
    var name: String
    var level: Int
    
    init(name: String, level: Int) { // 초기화 구문, 초기화 == 이니셜라이저
        self.name = name
        self.level = level
    }
}

let easymon = SecondMonster(name: "잭몬", level: 1) // 클래스를 초기화한 거고, 인스턴스를 만든 것.
// 초기화를 하려면 클래스가 갖고 있는 모든 요소들이 값이 있어야 함

easymon.name = "슈렉몬스터"
easymon.level = 3

print(easy.name, easy.level) // let으로 선언해줬는데 왜 데이터가 바뀌는가?

SecondMonster(name: "잭잭몬", level: 1)


// 구조체

// 구조체는 멤버와이즈 초기화구문이 자동으로 제공된다.
struct StructMonster {
    var name: String
    var level: Int = 1
}

let structMonster = StructMonster(name: "스몬이", level: 1)


