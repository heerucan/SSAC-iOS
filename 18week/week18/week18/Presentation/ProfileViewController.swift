//
//  ProfileViewController.swift
//  week18
//
//  Created by heerucan on 2022/11/02.
//

import UIKit
import RxSwift

class ProfileViewController: UIViewController {
    
    let viewModel = ProfileViewModel()
    
    let disposeBag = DisposeBag()

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        checkCOW()
        
        let phone = Phone()
        
        print(phone[2])
        print(phone.numbers[2])
    }

    func bindViewModel() {
        viewModel.profile
            .withUnretained(self)
            .subscribe { (vc, value) in
                print(value.user.email)
                vc.label.text = value.user.email
            } onError: { error in
                print(error.localizedDescription)
            }
            .disposed(by: disposeBag)
        
        viewModel.getProfile()
    }

    // MARK: - COW
    
    func checkCOW() {
        print("==========================================")

        var test = "jack"
        address(&test) // in out 매개변수
        var test2 = test
        address(&test2)
        
        print("==========================================")

        test2 = "sesac"
        address(&test)
        address(&test2)
        
        print(test[0], test[2])
        
        print("==========================================")
        var array = Array(repeating: "A", count: 100) // Array, Dictionary, Set ==> Collection 타입에서 일어난다.
        address(&array)
        
        var newArray = array // 값을 복사하더라도 실제로 복사하는 게 아니라 원본을 공유하고 있다.
        address(&newArray)
        
        newArray[0] = "B"
        address(&array)
        address(&newArray)
        
        print(array[safe: 0])
        print(newArray[safe: 0])
    }
    
    func address(_ value: UnsafeRawPointer) {
        let address = String(format: "%p", Int(bitPattern: value))
        print(address)
    }
}
