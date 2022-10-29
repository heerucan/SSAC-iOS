//
//  SubscribeViewController.swift
//  1617week
//
//  Created by heerucan on 2022/10/26.
//

import UIKit

import RxCocoa
import RxSwift

final class SubscribeViewController: UIViewController {
    
    // MARK: - DisposeBag
    
    private let disposeBag = DisposeBag()
    
    // MARK: - @IBOutlet

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
    
    // MARK: - Bind Data
    
    func bindData() {
        
        // 1. weak self
        button.rx.tap
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.label.text = "안녕 반가워"
            }
            .disposed(by: disposeBag)
           
        
        // 2.
        // 이벤트를 전달하는 옵저버블
        // 이벤트를 받는 옵저버
        button.rx.tap
            .withUnretained(self)
            .subscribe { (vc, _) in
                vc.label.text = "안녕 반가워"
            }
            .disposed(by: disposeBag)
        
        
        // 3.
        // UI가 업데이트 되는 거니까 -> main thread가 동작하는 것임
        // 근데 네트워크 통신이나 파일 다운로드 등 백그라운드 작업!!은?
        button.rx.tap
            .observe(on: MainScheduler.instance) // 다른 스레드로 동작하게 반영
            .withUnretained(self)
            .subscribe { (vc, _) in
                vc.label.text = "안녕 반가워"
            }
            .disposed(by: disposeBag)
        
        
        // 4. bind : Subscribe, mainScheduler, error 안해도 됨
        button.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.label.text = "안녕 반가워"
            }
            .disposed(by: disposeBag)
        
        
        // 5. operator로 데이터의 stream 조작
        button.rx.tap
            .map { "안녕 반가워" }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
        
        // 6. driver traits : bind의 특성과 동일
        button.rx.tap
            .map { "안녕 반가워" }
            .asDriver(onErrorJustReturn: "")
            .drive(label.rx.text)
            .disposed(by: disposeBag)
    }

}