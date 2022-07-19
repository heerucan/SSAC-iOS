//
//  AssignmentTableViewController.swift
//  TrendMedia
//
//  Created by heerucan on 2022/07/18.
//

import UIKit

enum SettingOptions: Int, CaseIterable {
    case total, personal, other
    
    var section: String {
        switch self {
        case .total: return "전체 설정"
        case .personal: return "개인 설정"
        case .other: return "기타"
        }
    }
    
    var rowTitle: [String] {
        switch self {
        case .total: return ["공지사항", "실험실", "버전 정보"]
        case .personal: return ["개인/보안", "알림", "채팅", "멀티프로필"]
        case .other: return ["고객센터/도움말"]
        }
    }
}

//enum Menu: CaseIterable {
//    case section
//    case firstCell
//    case secondCell
//    case thirdCell
//
//    var menu: [String] {
//        switch self {
//        case .section:
//            return ["전체 설정", "개인 설정", "기타"]
//        case .firstCell:
//            return ["공지사항", "실험실", "버전 정보"]
//        case .secondCell:
//            return ["개인/보안", "알림", "채팅", "멀티프로필"]
//        case .thirdCell:
//            return ["고객센터/도움말"]
//        }
//    }
//}

class AssignmentTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingOptions.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingOptions.allCases[section].section
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingOptions.allCases[section].rowTitle.count

//        switch section {
//        case 0: return Menu.firstCell.menu.count
//        case 1: return Menu.secondCell.menu.count
//        case 2: return Menu.thirdCell.menu.count
//        default: return Int()
//        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "assignmentCell")!
        cell.textLabel?.textColor = .lightGray
        cell.textLabel?.font = .boldSystemFont(ofSize: 12)
        cell.textLabel?.text = SettingOptions.allCases[indexPath.section].rowTitle[indexPath.row]
        
//        switch indexPath.section {
//        case 0:  = Menu.firstCell.menu[indexPath.row]
//        case 1: cell.textLabel?.text = Menu.secondCell.menu[indexPath.row]
//        case 2: cell.textLabel?.text = Menu.thirdCell.menu[indexPath.row]
//        default: return cell
//        }
        
        return cell
    }
}
