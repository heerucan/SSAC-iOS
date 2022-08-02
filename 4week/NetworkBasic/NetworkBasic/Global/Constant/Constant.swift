//
//  Constant.swift
//  NetworkBasic
//
//  Created by heerucan on 2022/08/01.
//

import Foundation

enum StoryboardName: String {
    case Main
    case Search
    case Setting
}

//StoryboardName.Main.rawValue

struct StoryboardNames {
    
    // 접근제어를 통해 초기화를 막을 수 있음
    private init() { }
    
    static let main = "Main"
    static let search = "Search"
    static let setting = "Setting"
}

// 열거형 내에서 타입 프로퍼티 사용하는 방식
enum Storyboard {
    // 그냥 저장 프로퍼티는 쓸 수 없는데
    // 타입 프로퍼티는 쓸 수 있다.
    static let main = "Main"
    static let search = "Search"
    static let setting = "Setting"
}

enum APIKey {
    static let movie = "f5eef3421c602c6cb7ea224104795888&targetDt"
}
// 열거형 내에서 타입 프로퍼티를 쓸 경우의 장점은?
/*
 1. struct 안에서 타입 프로퍼티 vs enum 내에서 타입 프로퍼티 -> 인스턴스 생성 방지
 : struct는 초기화가 가능
 : enum은 초기화가 아예 불가능
 
 별개로 접근제어를 통해 초기화 방지를 할 수 있음
 
 인스턴스 생성을 하면 어떤 문제가 있냐면, 한 공간에서 생성하고 공통적으로 사용하겠다는 뜻임
 재사용하겠다는 목적임, 근데 이 규칙을 깨고 새 인스턴스를 만든다!
 그러면 곳곳에 인스턴스가 산재하게 되고, 코드에 대한 제약을 깨게 되는 것이고
 코드의 일관성이 흔들리게 된다.
 굳이 만들 필요 없는 인스턴스를 만드는 상황이 발생
 */

/*
 2. enum case vs enum static
 : enum case의 rawValue가 중복될 수 없음
 
 */

//enum FontName: String {
//    case title = "Pretendard"
//    case body = "Pretendard"
//    case caption = "AppleSD"
//}
