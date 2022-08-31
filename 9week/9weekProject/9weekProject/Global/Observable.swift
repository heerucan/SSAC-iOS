//
//  Observable.swift
//  9weekProject
//
//  Created by heerucan on 2022/08/31.
//

import Foundation

class Observable<T> { // 양방향 바인딩
    
    // 리스너를 구현? -> value의 값이 바뀌면 didSet을 통해 대응해줄 것이야! 근데 뭘 할 지 몰라.. 다양한 기능들을 해줄 수 있잖어?
    
    /*
     어떤 함수가 들어갈 지 모르지만 매개변수로 T 제네릭을 넣어줌
     value에 변화가 오면 listener를 실행시켜줄 것임
     completion 바이브 클로저임
     didSet 구문 안에서 함수 호출 연산자를 해주고 있어서
     */
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            print("didSet", value)
            listener?(value) // label.text = value처럼 해주려고 함
        }
    }
    
    // didSet이 없다면 초기화가 가능하기에 안해줘도 되는 부분임
    init(_ value: T) {
        self.value = value
    }
    

    // 나 바인딩 시켜줄 건데,
    func bind(_ closure: @escaping (T) -> Void) {
        print("옵저버블의 바인드함수")
        closure(value) // 외부에서 들어온 값을 먼저 반영해주고
        listener = closure // 들어온 값을 내부에서도 반영해주기 위해 listener도 타입이 같아서 프로퍼티 변수에 담아주고, didSet을 통해 변경 시마다 대응
    }
    
}

class User {
        
    private var listener: ((String) -> Void)?
    
    var value: String {
        didSet {
            print("데이터 바뀜!")
            listener?(value) // label.text = value처럼 해주려고 함
        }
    }
    
    init(_ value: String) {
        self.value = value
    }
}
