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


// Formatted

