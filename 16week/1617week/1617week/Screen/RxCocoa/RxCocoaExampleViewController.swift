//
//  RxCocoaExampleViewController.swift
//  1617week
//
//  Created by heerucan on 2022/10/24.
//

import UIKit

import RxCocoa
import RxSwift

final class RxCocoaExampleViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var simpleLabel: UILabel!
    @IBOutlet weak var simpleSwitch: UISwitch!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var signName: UITextField!
    @IBOutlet weak var signEmail: UITextField!
    @IBOutlet weak var signButton: UIButton!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setPickerView()
        setSwitch()
        setSign()
        setOperator()
    }
    
    // MARK: - Custom Method
    
    private func setOperator() {
        
        Observable.repeatElement("Ruhee")
            .take(5)
            .subscribe { value in
                print("repeatElement - ", value)
            } onError: { error in
                print("repeatElement - ", error)
            } onCompleted: {
                print("repeatElement - onCompleted")
            } onDisposed: {
                print("repeatElement - onDisposed")
            }
            .disposed(by: disposeBag)
        
        
        let intervalObservable = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe { value in
                print("repeatElement - ", value)
            } onError: { error in
                print("repeatElement - ", error)
            } onCompleted: {
                print("repeatElement - onCompleted")
            } onDisposed: {
                print("repeatElement - onDisposed")
            }
//            .disposed(by: disposeBag)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            intervalObservable.dispose()
        }
        
        let itemsA = ["루희", "루루", "루키", "후리", "훌"]
        let itemsB = ["소깡", "sokyte", "도영이꺼", "쏘"]
        
        
        // just
        Observable.just(itemsA)
            .subscribe { value in
                print("just - ", value)
            } onError: { error in
                print("just - ", error)
            } onCompleted: {
                print("just - onCompleted")
            } onDisposed: {
                print("just - onDisposed")
            }
            .disposed(by: disposeBag)

        // of
        Observable.of(itemsA, itemsB)
            .subscribe { value in
                print("of - ", value)
            } onError: { error in
                print("of - ", error)
            } onCompleted: {
                print("of - onCompleted")
            } onDisposed: {
                print("of - onDisposed")
            }
            .disposed(by: disposeBag)
        
        
        // from
        Observable.from(itemsA)
            .subscribe { value in
                print("from - ", value)
            } onError: { error in
                print("from - ", error)
            } onCompleted: {
                print("from - onCompleted")
            } onDisposed: {
                print("from - onDisposed")
            }
            .disposed(by: disposeBag)
    }
    
    private func setSign() {
        // ex. 텍1, 텍2 - 옵저버블 -> 둘 중 하나만 바껴도 이벤트를 보내!
        // 레이블 - 옵저버
        // ui 요소 = bind + 실패할 이유가 없으니까!!
        // 실시간으로 감지해야 하니까 항상 rx가 붙는 것
        // combineLatest는 등록된 객체 중에 하나만 바껴도 이벤트 방출하는 것
        Observable.combineLatest(signName.rx.text.orEmpty, signEmail.rx.text.orEmpty) { (value1, value2) in
            "name은 \(value1)이고, 이메일은 \(value2)입니다."
        }.bind(to: simpleLabel.rx.text) // 이 이벤트를 누구에게 보내줄 건데?? 라는 부분
            .disposed(by: disposeBag)
        
        
        // 텍필1에 있는 내용을 가져온 것
        // 데이터의 흐름 Stream을 타면서 타입이 구독하기 전까지 계속 바뀔 수 있음
        signName // UITextField
            .rx // Reactive
            .text // String?
            .orEmpty // String
            .map { $0.count < 4 } // Int -> Bool
            .bind(to: signEmail.rx.isHidden, signButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        signEmail.rx.text.orEmpty
            .map { $0.count > 4 }
            .bind(to: signButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        signButton.rx.tap
            .subscribe { _ in
                self.showAlert()
            }
            .disposed(by: disposeBag)

    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "알림창", message: "하위나는알림메시지", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    private func setSwitch() {
        Observable.of(true) // just? of?
            .bind(to: simpleSwitch.rx.isOn)
            .disposed(by: disposeBag)
    }
    
    private func setTableView() {
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let items = Observable.just([
            "First Item",
            "Second Item",
            "Third Item"
        ])
        
        // 옵저버블을 누가 구독하냐? -> tableView
        items
            .bind(to: tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(element) @ row \(row)"
                return cell
            }
            .disposed(by: disposeBag)
        
        // model -> 데이터
        // item -> indexPath
        tableView.rx.modelSelected(String.self)
            .map { data in
                "\(data)를 클릭했습니다"
            }
            .bind(to: simpleLabel.rx.text)
            .disposed(by: disposeBag) // 메모리해제

    }
    
    private func setPickerView() {
        
        let items = Observable.just([
                "영화",
                "애니메이션",
                "드라마",
                "기타"
            ])
     
        items
            .bind(to: pickerView.rx.itemTitles) { (row, element) in
                return element
            }
            .disposed(by: disposeBag)
        
        pickerView.rx.modelSelected(String.self)
            .map { $0.first }
            .bind(to: simpleLabel.rx.text)
//            .subscribe(onNext: { value in
//                print(value)
//            })
            .disposed(by: disposeBag)
    }
}
