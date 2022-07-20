//
//  ShoppingTableViewController.swift
//  TrendMedia
//
//  Created by heerucan on 2022/07/20.
//

import UIKit

class ShoppingTableViewController: UITableViewController {
    
    var list = ["그립톡 구매하기", "사이다 구매", "아이패드 케이스 최저가 알아보기", "양말"]

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func clickedAddButton(_ sender: UIButton) {
        textField
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCell", for: indexPath) as! ShoppingTableViewCell
        cell.listLabel.text = list[indexPath.row]
        return cell
    }

}
