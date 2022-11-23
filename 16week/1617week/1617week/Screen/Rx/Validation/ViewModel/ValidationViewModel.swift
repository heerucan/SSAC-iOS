//
//  ValidationViewModel.swift
//  1617week
//
//  Created by heerucan on 2022/10/27.
//

import Foundation

import RxCocoa
import RxSwift
import RxRelay

final class ValidationViewModel {
    
//    let validText = BehaviorRelay(value: "8자 이상 작성해주세요")

    struct Input {
        // 텍스트필드의 인풋속성을 여기로 가져온 것
        let text: ControlProperty<String?> // nameTextField.rx.text
        let validText = BehaviorRelay(value: "8자 이상 작성해주세요")
        
        let tap: ControlEvent<Void> // stepButton.rx.tap
    }
    
    struct Output {
        // 저 바로 위 인풋을 아웃풋으로 바꿔서 Bool 타입으로 만들어줘야 하는데 그걸 transform 메소드가 해줌
        let validation: Observable<Bool>
        let tap: ControlEvent<Void>
        let text: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        // let validation = nameTextField.rx.text와 같은 맥락임
        let valid = input.text
            .orEmpty
            .map { $0.count >= 8 }
            .share()
//            .asDriver(onErrorJustReturn: false)
        
        let text = input.validText.asDriver()
    
        
        return Output(validation: valid, tap: input.tap, text: text)
    }
}
