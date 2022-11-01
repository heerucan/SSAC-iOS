//
//  CommonViewModel.swift
//  1617week
//
//  Created by heerucan on 2022/11/01.
//

import Foundation

/*
 ViewModel의 기본적인 세팅을 위해 프로토콜을 만들어줌
 */

// associatedtype == generic

protocol CommonViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
