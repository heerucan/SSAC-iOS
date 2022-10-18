//
//  SimpleTableViewController.swift
//  1617week
//
//  Created by heerucan on 2022/10/18.
//

import UIKit

final class SimpleTableViewController: UITableViewController {
    
    let list = ["바스버거", "UFO버거", "슈비버거", "꼬깔콘"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "")!
//        cell.textLabel?.text = list[indexPath.row]
        
        let cell = UITableViewCell()
        
        var content = cell.defaultContentConfiguration()
        content.text = list[indexPath.row] // textLabel
        content.secondaryText = "안녕하세요" // detailTextLabel
        cell.contentConfiguration = content
        return cell
    }
}
