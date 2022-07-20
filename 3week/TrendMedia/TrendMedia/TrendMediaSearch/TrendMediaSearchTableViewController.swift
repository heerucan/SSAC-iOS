//
//  TrendMediaSearchTableViewController.swift
//  TrendMedia
//
//  Created by heerucan on 2022/07/20.
//

import UIKit

enum Movie {
    case poster
    case title
    case date
    case story
}

class TrendMediaSearchTableViewController: UITableViewController {
    
    var movieList = ["해리포터 20주년", "잉크 마법사의 여행", "죽의 성물", "죽음의 성물2", "불의 잔", "마법사의 돌", "마법사의 방"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 0
    }
}
