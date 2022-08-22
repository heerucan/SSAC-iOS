//
//  ShoppingTableViewController.swift
//  TrendMedia
//
//  Created by heerucan on 2022/07/20.
//

import UIKit

import RealmSwift

class ShoppingTableViewController: UITableViewController {
    
    // MARK: - Property
    
    let localRealm = try! Realm()
    var tasks: Results<ShoppingList>!
    
    // MARK: - @IBOutlet
    
    @IBOutlet var shoppingTableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.placeholder = "쇼핑리스트를 입력하세요"
        getRealmData()
        shoppingTableView.rowHeight = 80
    }
    
    // MARK: - @IBAction

    @IBAction func clickedAddButton(_ sender: UIButton) {
        guard let text = textField.text else { return }
        let task = ShoppingList(list: text)
        try! localRealm.write {
            localRealm.add(task)
            print("Realm에 데이터 저장 성공")
        }
        shoppingTableView.reloadData()
        textField.text = ""
        textField.placeholder = "쇼핑리스트를 입력하세요"
        textField.resignFirstResponder()
    }
    
    func getRealmData() {
        self.tasks = localRealm.objects(ShoppingList.self)
        print(tasks!)
    }
    
    // MARK: - TableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks == nil ? 0 : tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCell", for: indexPath) as! ShoppingTableViewCell
        cell.listLabel.text = tasks[indexPath.row].list
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            list.remove(at: indexPath.row)
            shoppingTableView.reloadData()
        }
    }
}
