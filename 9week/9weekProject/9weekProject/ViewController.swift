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
//        LottoAPIManager.requestLotto(drwNo: 1011) { data, error in
//            guard let data = data else {
//                return
//            }
//            self.lotto.text = "\(data.drwNo)"
//            print(data, data.drwNoDate)
//        }
        
        viewModel.fetchPerson(query: "lee")
        viewModel.list.bind { person in
            print("뷰컨의 바인드구문")
//            self.viewModel.list.value = person
            self.lotto.text = person.results.first?.name
            self.tableView.reloadData()
        }
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
