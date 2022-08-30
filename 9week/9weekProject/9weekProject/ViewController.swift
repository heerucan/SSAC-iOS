//
//  ViewController.swift
//  9weekProject
//
//  Created by heerucan on 2022/08/30.
//

import UIKit

class ViewController: UIViewController {
    
    var array: Person?

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
        
        PersonAPIManager.requestPerson(query: "tom") { data, error in
            guard let data = data else {
                return
            }
            self.lotto.text = data.results.map { $0.name }.first
            self.array = data
            dump(data)
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = array?.results[indexPath.row].name
        cell.detailTextLabel?.text = array?.results[indexPath.row].knownForDepartment
        return cell
    }
}
