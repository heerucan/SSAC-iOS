//
//  Sample.swift
//  9weekProject
//
//  Created by heerucan on 2022/09/01.
//

import Foundation

class User<T> {
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(completion: @escaping (T) -> Void) {
        
        completion(value)
        listener = completion
    }
}
