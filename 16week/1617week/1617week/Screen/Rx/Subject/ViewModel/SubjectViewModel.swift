//
//  SubjectViewModel.swift
//  1617week
//
//  Created by heerucan on 2022/10/25.
//

import Foundation

import RxSwift

final class SubjectViewModel {
    
    var contactData = [
        Contact(name: "후리방궁", age: 25, number: "01010110101"),
        Contact(name: "쏘깡잉", age: 25, number: "9292929292"),
        Contact(name: "태리야낑", age: 26, number: "6464646464")
    ]
    
    var list = PublishSubject<[Contact]>()
    
    func fetchData() {
        list.onNext(contactData)
    }
    
    func resetData() {
        list.onNext([])
    }
    
    func newData() {
        let new = Contact(name: "후리스콜링", age: Int.random(in: 10...50), number: "")
        contactData.append(new)
        list.onNext(contactData)
    }
    
    func filterData(query: String) {
        if query.isEmpty {
            list.onNext(contactData)
        } else {
            let result = contactData.filter { $0.name.contains(query)}
            list.onNext(result)
        }
    }
}
