//
//  SubjectViewModel.swift
//  1617week
//
//  Created by heerucan on 2022/10/25.
//

import Foundation

import RxSwift
import RxCocoa

final class SubjectViewModel: CommonViewModel {
    
    var contactData = [
        Contact(name: "후리방궁", age: 25, number: "01010110101"),
        Contact(name: "쏘깡잉", age: 25, number: "9292929292"),
        Contact(name: "태리야낑", age: 26, number: "6464646464")
    ]
    
    var list = PublishRelay<[Contact]>()
    
    func fetchData() {
        list.accept(contactData)
    }
    
    func resetData() {
        list.accept([])
    }
    
    func newData() {
        let new = Contact(name: "후리스콜링", age: Int.random(in: 10...50), number: "")
        contactData.append(new)
        list.accept(contactData)
    }
    
    func filterData(query: String) {
        if query.isEmpty {
            list.accept(contactData)
        } else {
            let result = contactData.filter { $0.name.contains(query)}
            list.accept(result)
        }
    }
    
    struct Input { // 가공되지 않은 데이터가 뷰모델로 들어와
        let addTap: ControlEvent<Void>
        let newTap: ControlEvent<Void>
        let resetTap: ControlEvent<Void>
        let searchText: ControlProperty<String?>
    }
    
    struct Output { // 가공된 데이터가 뷰모델에서 나가
        let addTap: ControlEvent<Void>
        let newTap: ControlEvent<Void>
        let resetTap: ControlEvent<Void>
        let list: Driver<[Contact]>
        let searchText: Observable<String>
            
    }
    
    func transform(input: Input) -> Output {
        let list = list.asDriver(onErrorJustReturn: [])
        let text = input.searchText // searchBar.rx.text랑 같음
            .orEmpty // VC -> VM (Input)
            .debounce(RxTimeInterval.seconds(1),
                      scheduler: MainScheduler.instance) // wait - 1초 기다리고 검색
            .distinctUntilChanged()
        
        return Output(addTap: input.addTap,
                      newTap: input.newTap,
                      resetTap: input.resetTap,
                      list: list,
                      searchText: text)
    }
}
