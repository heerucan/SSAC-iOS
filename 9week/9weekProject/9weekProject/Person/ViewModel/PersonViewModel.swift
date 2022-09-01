//
//  PersonViewModel.swift
//  9weekProject
//
//  Created by heerucan on 2022/08/31.
//

import Foundation

// controller가 하던 일부의 역할을 viewmodel이 하게 되는 것임
class PersonViewModel {
    
    var list: Observable<Person> = Observable(Person(page: 0, results: [], totalPages: 0, totalResults: 0))
    
    func fetchPerson(query: String) {
        PersonAPIManager.requestPerson(query: query) { person, error in
            guard let person = person else {
                return
            }
            print(person, "fetchPerson 값이 있나?")
            self.list.value = person
            dump(person)
        }
    }
    
    // value의 타입이 제네릭을 통해서 Person이라고 위에 써줘서 value는 Person인 것임
    var numberOfRowsInSection: Int {
        return list.value.results.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> Result {
        return list.value.results[indexPath.row]
    }
}
