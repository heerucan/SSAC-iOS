//
//  ViewController.swift
//  9weekProject
//
//  Created by heerucan on 2022/08/30.
//

import UIKit

class ViewController: UIViewController {
    
    private var viewModel = PersonViewModel()
    
    @IBOutlet weak var lotto: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        viewModel.fetchPerson(query: "lee")
//        viewModel.list.bind { person in
//            print("뷰컨의 바인드구문")
//            print(person, "bind 호출, 값이 잇나?")
//            self.lotto.text = person.results.first?.name
//            self.tableView.reloadData()
//        }
        
        let user = User("후리방구")

        
        
        user.bind { value in
            print(value, "bind 함수")
        }
        
        user.value = "방구뿡"
        user.value = "후리스콜링"
        
        
        var number1 = 10
        var number2 = 3
        
        print(number1 - number2)
        
        number1 = 3
        number2 = 1
        
        var number3 = Observable(10)
        var number4 = Observable(3)
        
        number3.bind { a in
            print("Observable", number3.value - number4.value)
        }
        
        number3.value = 100
        number3.value = 200
        number3.value = 50
    }
    
    func fetchLotto(drwNo: Int) {
        //        LottoAPIManager.requestLotto(drwNo: 1011) { data, error in
        //            guard let data = data else {
        //                return
        //            }
        //            self.lotto.text = "\(data.drwNo)"
        //            print(data, data.drwNoDate)
        //        }
                
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let data = viewModel.cellForRowAt(at: indexPath)
        
        cell.textLabel?.text = data.name
        cell.detailTextLabel?.text = data.knownForDepartment
        return cell
    }
}

extension UIColor {
    // Base Color
    static let black100 = UIColor(named: "ruheeBlack")
}
