//
//  SubscribeViewController.swift
//  1617week
//
//  Created by heerucan on 2022/10/26.
//

import UIKit

import RxAlamofire
import RxCocoa
import RxDataSources
import RxSwift

final class SubscribeViewController: UIViewController {
    
    // MARK: - DisposeBag
    
    private let disposeBag = DisposeBag()
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Int>>
    { dataSource, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = "\(item)"
        return cell
    }
    
    // MARK: - @IBOutlet

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        testRxAlamofire()
        testRxDataSource()
        
        Observable.of(1,2,3,4,5,6,7,8,9,10)
            .skip(3) // 앞에서 3개의 이벤트는 무시하고 4부터 방출
            .filter { $0 % 2 == 0 } // 2의 배수만 방출
            .debug()
            .map { $0 * 2 } // 해당 이벤트에 대해 2를 곱해서 방출
            .subscribe({ value in
//                print("----", value)
            })
            .disposed(by: disposeBag)
        
        bindData()
    }
    
    // MARK: - Bind Data
    
    func bindData() {
        
        // 1. weak self
        let sample = button.rx.tap
        sample
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
//            .debug() // print 해주는 것
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

// MARK: - RxDataSource

extension SubscribeViewController {
    private func testRxDataSource() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        //RxTableViewSectionedReloadDataSource -> diffable이랑 비슷하게 생각하렴
        // String -> model
        // Int -> items
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].model
        }
        
        dataSource.canEditRowAtIndexPath = { dataSource, indexPath in
          return true
        }
        
        Observable
            .just([
                SectionModel(model: "첫번째", items: [1, 2, 3]),
                SectionModel(model: "두번째", items: [1, 2, 3]),
                SectionModel(model: "세번째", items: [1, 2, 3])
            ])
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

// MARK: - RxAlamofire

extension SubscribeViewController {
    private func testRxAlamofire() {
        
        // Success Error 밖에 없잖아? 네트워크는?
        
        let url = APIKey.searchURL + "heart"
        request(.get, url, headers: ["Authorization": APIKey.authorization])
            .data() // 데이터 스트림을 data로 바꿔줘야 함
            .decode(type: SearchPhoto.self, decoder: JSONDecoder())
            .withUnretained(self)
            .subscribe(onNext: { (vc, value) in
                print(value.results[0].urls)
                vc.label.text = "\(value.results[0].urls)"
            }, onError: { error in
                print(error.localizedDescription)
            }, onCompleted: {
                print("completed")
            }, onDisposed: {
                print("disposed")
            })
            .disposed(by: disposeBag)
    }
}
