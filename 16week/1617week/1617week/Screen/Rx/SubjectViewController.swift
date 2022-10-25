//
//  SubjectViewController.swift
//  1617week
//
//  Created by heerucan on 2022/10/25.
//

import UIKit

import RxSwift
import RxCocoa

final class SubjectViewController: UIViewController {

    // MARK: - DisposeBag
    
    let disposeBag = DisposeBag()
    
    
    // MARK: - Property
    
    private let publish = PublishSubject<Int>() // 초기값이 없는 빈 상태
    private let behavior = BehaviorSubject(value: 100) // 초기값 필수
    private let replay = ReplaySubject<Int>.create(bufferSize: 3) // bufferSize 작성된 이벤트 갯수만큼 메모리에서 이벤트를 가지고 있다가, subscribe 직 후 한 번에 이벤트 전달
    private let async = AsyncSubject<Int>()
    
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var resetButton: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        asyncSubject()
//        replaySubject()
//        behaviorSubject()
//        publishSubject()
    }
    
    
 
}

// MARK: - Subject Practice

extension SubjectViewController {
    
    // MARK: - Async Subject
    
    private func asyncSubject() {
        
        print("async =====================")
        
        async.onNext(11)
        async.onNext(22)
        async.onNext(33)
        async.onNext(44)
        async.onNext(55)
        
        async
            .subscribe { value in
                print("async - ", value)
            } onError: { error in
                print("async - ", error)
            } onCompleted: {
                print("async completed")
            } onDisposed: {
                print("async disposed")
            }
            .disposed(by: disposeBag)

        async.onNext(00000)
        async.onNext(6666666)
        async.onCompleted()
        async.onNext(9494949)
        
    }
        
    // MARK: - Replay Subject
    
    private func replaySubject() {
        
        print("replay =====================")
        
        replay.onNext(1)
        replay.onNext(22)
//        replay.onNext(333)
//        replay.onNext(4444)
//        replay.onNext(55555)
        
        replay
            .subscribe { value in
                print("replay - ", value)
            } onError: { error in
                print("replay - ", error)
            } onCompleted: {
                print("replay completed")
            } onDisposed: {
                print("replay disposed")
            }
            .disposed(by: disposeBag)

        replay.onNext(0)
        replay.onNext(000)
        replay.onCompleted()
        replay.onNext(000000)
        
    }
    
    // MARK: - Behavior Subject
    
    private func behaviorSubject() {
        
        // 구독 전에 최근 값을 방출
        
        print("behavior =====================")
        
        behavior.onNext(124)
        behavior.onNext(9989)
        
        behavior
            .subscribe { value in
                print("behavior - ", value)
            } onError: { error in
                print("behavior - ", error)
            } onCompleted: {
                print("behavior completed")
            } onDisposed: {
                print("behavior disposed")
            }
            .disposed(by: disposeBag)

        behavior.onNext(3)
        behavior.onNext(44)
        behavior.onCompleted()
        behavior.onNext(9494949)
    }
    
    // MARK: - Publish Subject
    
    private func publishSubject() {
        
        print("publish =====================")
        
        publish.onNext(124)
        publish.onNext(9989)
        
        publish
            .subscribe { value in
                print("publish - ", value)
            } onError: { error in
                print("publish - ", error)
            } onCompleted: {
                print("publish completed")
            } onDisposed: {
                print("publish disposed")
            }
            .disposed(by: disposeBag)

        publish.onNext(3)
        publish.onNext(44)
        publish.onCompleted()
        publish.onNext(9494949)
    }
}
