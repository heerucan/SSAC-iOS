//
//  ValidationViewController.swift
//  1617week
//
//  Created by heerucan on 2022/10/27.
//

import UIKit

import RxSwift
import RxCocoa

final class ValidationViewController: UIViewController {
    
    // MARK: - DisposeBag
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Property
    
    private let viewModel = ValidationViewModel()
    
    // MARK: - @IBOutlet

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var validationLabel: UILabel!
    @IBOutlet weak var stepButton: UIButton!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
//        observableVSSubject()
    }
    
    // MARK: - Bind
    
    private func bind() {
        
        // MARK: - After
        let input = ValidationViewModel.Input(text: nameTextField.rx.text, tap: stepButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.text
            .drive(validationLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.validation
            .bind(to: stepButton.rx.isEnabled, validationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        
        
        // MARK: - Before
        
        /*
         텍필에서 글을 입력 후 버튼 누르면
         경고라벨이 발생!!
         버튼 누르면 -> 발생시켜!!
         옵저버블(버튼) -> 옵저버(라벨)
         작성한 글을 업데이트시키는 게 불가능해
         동시에 할 수 있는 서브젝트
         UI에 친화적인 아이인 Relay
                
         Stream에서 연산자를 만나며 데이터의 타입이 변경
        nameTextField.rx.text // String?
            .orEmpty // String
            .map { $0.count >= 8 } // Bool
            .bind(to: stepButton.rx.isEnabled, validationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
         뷰모델의 validText를 validationText에 전달하겠다!
         근데 UI에 특화된 요소니까, Relay로 만든 것이고 짝꿍은 Drive
         */
        
        viewModel.validText // Output
            .asDriver()
            .drive(validationLabel.rx.text)
            .disposed(by: disposeBag)
                
        let validation = nameTextField.rx.text // 데이터를 핸들링하고 있음 Input
            .orEmpty
            .map { $0.count >= 8 }
            .asDriver(onErrorJustReturn: false)
//            .share()

        validation // Input
            .drive(stepButton.rx.isEnabled, validationLabel.rx.isHidden)
            .disposed(by: disposeBag)

        output.validation  // Input
            .bind { [weak self] value in
                guard let self = self else { return }
                let color: UIColor = value ? .systemPink : .lightGray
                self.stepButton.backgroundColor = color
            }
            .disposed(by: disposeBag)
        
        /*
         subscribe에 해당하는 요소인데 ->
         이벤트를 보내면 성공할 수도, 실패할 수도 있으니까!!
         이벤트가 전달될 때 어떻게 처리가 되는가!!
         근데 tap 같은 경우는 거의 next만 처리됨!
         그래서 bind로 변경할 것임
        */
        
        output.tap // Input
            .bind { _ in
                print("SHOW ALERT")
            }
            .disposed(by: disposeBag)

        
    }
    
    // MARK: - 옵저버블과 서브젝트 비교
    
    private func observableVSSubject() {
        
        // MARK: - Observable
        // 옵저버블
        let sampleInt = Observable<Int>.create { observer in
            observer.onNext(Int.random(in: 1...100))
            return Disposables.create()
        }
       
        // 옵저버블에 해당하는 옵저버 총 3개 만들었음
        sampleInt.subscribe { value in
            print("sampleInt:", value)
        }
        .disposed(by: disposeBag)
        
        sampleInt.subscribe { value in
            print("sampleInt:", value)
        }
        .disposed(by: disposeBag)
        
        sampleInt.subscribe { value in
            print("sampleInt:", value)
        }
        .disposed(by: disposeBag)
        
        
        // MARK: - Subject
        // 초기값 가지는 서브젝트
        let subjectInt = BehaviorSubject(value: 0)
        subjectInt.onNext(Int.random(in: 1...100))
        
        subjectInt.subscribe { value in
            print("subjectInt:", value)
        }
        .disposed(by: disposeBag)
        
        subjectInt.subscribe { value in
            print("subjectInt:", value)
        }
        .disposed(by: disposeBag)
        
        subjectInt.subscribe { value in
            print("subjectInt:", value)
        }
        .disposed(by: disposeBag)
    }
    
    // MARK: - Drive
    
    private func testDrive() {
        let testA = stepButton.rx.tap
            .map { "안녕하세요" } // String
            .asDriver(onErrorJustReturn: "") // 해당객체는 Drive를 쓸 수 있는 객체로 변경됨
//            .share()
        
        testA
            .drive(validationLabel.rx.text)
            .disposed(by: disposeBag)
        
        testA
            .drive(nameTextField.rx.text)
            .disposed(by: disposeBag)
        
        testA
            .drive(stepButton.rx.title())
            .disposed(by: disposeBag)
    }

}
