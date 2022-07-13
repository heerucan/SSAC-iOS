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

var boss = BossMonster()
boss.bossAttack()
boss.levelLimit
boss.speed
boss.attack()

//class FinalBossMonster: BossMonster {
//
//}
//
//var finalBoss = FinalBossMonster()
//finalBoss.bossAttack()
//finalBoss.levelLimit
//finalBoss.speed
