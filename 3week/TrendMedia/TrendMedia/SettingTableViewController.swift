//
//  SettingTableViewController.swift
//  TrendMedia
//
//  Created by heerucan on 2022/07/18.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    var birthdayGirls = ["소깡", "체이준", "수빙수", "민굥이", "디오니소스"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 섹션의 개수 (옵션)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "생일인 친구"
        } else if section == 1 {
            return "친구 401명"
        }  else if section == 2 {
            return "즐겨찾기"
        } else {
            return "섹션"
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "푸터푸터"
    }
    
    // 1. 셀의 개수 (필수)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return birthdayGirls.count
        } else if section == 1 {
            return 2
        } else if section == 2 {
            return 10
        } else {
            return 3
        }
    }
    
    // 2. 셀의 디자인과 데이터 (필수)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 복붙과 같은 효과가 일어남
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")!
        
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.textLabel?.text = birthdayGirls[0]
            } else if indexPath.row == 1 {
                // birthdayGirls의 배열내에 1이라는 숫자를 넣는 것 대신에 indexPath.row를 넣어줄 수 있다.
                cell.textLabel?.text = birthdayGirls[indexPath.row]
            }
        }
        
        if indexPath.section == 0 {
            cell.textLabel?.text = birthdayGirls[indexPath.item]
            cell.textLabel?.textColor = .systemRed
            cell.textLabel?.font = .boldSystemFont(ofSize: 20)
        } else if indexPath.section == 1 {
            cell.textLabel?.text = "1셀 텍스트"
            cell.textLabel?.textColor = .systemOrange
            cell.textLabel?.font = .italicSystemFont(ofSize: 20)
        } else if indexPath.section == 2 {
            cell.textLabel?.text = "2셀 텍스트"
            cell.textLabel?.textColor = .systemYellow
            cell.textLabel?.font = .boldSystemFont(ofSize: 20)
        }
        
        // 왜 else를 안써도 대응이 되는 걸까?!
        // 왜냐하면 마지막에 return cell을 해주고 있기 때문
        
        return cell
    }
    
}
