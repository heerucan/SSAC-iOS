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
    var tasks: Results<ShoppingList>! {
        didSet {
            shoppingTableView.reloadData()
        }
    }
    
    var menuItems: [UIAction] {
        return [favoriteMenu, titleMenu]
    }
    
    var menu: UIMenu {
        return UIMenu(title: "정렬 및 필터", children: menuItems)
    }
    
    lazy var favoriteMenu = UIAction(title: "중요도순") { _ in
        self.getRealmData("favorite", true)
    }
    
    lazy var titleMenu = UIAction(title: "사야 할 물품 검색", image: UIImage(systemName: "eyes")) { _ in
        let alert = UIAlertController(title: "검색", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "사기로 한 물품을 검색해보세요!"
        }
        
        let ok = UIAlertAction(title: "확인", style: .default) { action in
            guard let textFields = alert.textFields else { return }
            guard let text = textFields[0].text else { return }
            self.tasks = self.localRealm.objects(ShoppingList.self).filter("list CONTAINS '"+text+"'" )
        }
        
        let cancel = UIAlertAction(title: "취소", style: .default)
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    lazy var leftBarButton = UIBarButtonItem(title: "더보기",
                                             primaryAction: nil,
                                             menu: menu)
    
    // MARK: - @IBOutlet
    
    @IBOutlet var shoppingTableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - @IBAction

    @IBAction func clickedAddButton(_ sender: UIButton) {
        guard let text = textField.text else { return }
        let task = ShoppingList(list: text)
        try! localRealm.write {
            localRealm.add(task)
        }
        textField.text = ""
        textField.placeholder = "쇼핑리스트를 입력하세요"
        textField.resignFirstResponder()
    }
    
    // MARK: - Custom Method
    
    func configureUI() {
        getRealmData()
        textField.placeholder = "쇼핑리스트를 입력하세요"
        navigationItem.leftBarButtonItem = leftBarButton
        shoppingTableView.rowHeight = 80
    }
    
    func getRealmData(_ keyPath: String = "check", _ ascending: Bool = false) {
        self.tasks = localRealm.objects(ShoppingList.self).sorted(byKeyPath: keyPath, ascending: ascending)
    }
    
    // MARK: - @objc
    
    @objc func touchupStarButton(_ sender: UIButton) {
        do {
            try! localRealm.write {
                self.tasks[sender.tag].favorite = !self.tasks[sender.tag].favorite
            }
            self.shoppingTableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
        }
    }
    
    // MARK: - TableViewDataSource
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        tableView.allowsSelection = false
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks == nil ? 0 : tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCell", for: indexPath) as! ShoppingTableViewCell
        let image = tasks[indexPath.row].favorite ? "star.fill" : "star"
        cell.starButton.setImage(UIImage(systemName: image), for: .normal)
        cell.listLabel.text = tasks[indexPath.row].list
        cell.starButton.tag = indexPath.row
        cell.starButton.addTarget(self, action: #selector(touchupStarButton(_:)), for: .touchUpInside)
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
          tableView.beginUpdates()
            do {
                try? self.localRealm.write {
                    self.localRealm.delete(self.tasks[indexPath.row])
                }
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}
