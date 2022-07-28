//
//  SearchViewController.swift
//  NetworkBasic
//
//  Created by heerucan on 2022/07/27.
//

import UIKit

/*
 Swift Protocol
 - Delegate
 - DataSource
 */

final class SearchViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var searchTableView: UITableView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
    }
    
    // MARK: - InitUI
    
    private func configureUI() {
        
    }
    
    private func configureTableView() {
        // 연결고리 작업 : 테이블뷰가 해야 할 역할 > 뷰 컨트롤러에게 요청
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        // 테이블뷰가 사용할 테이블뷰 셀(XIB) 등록 작업
        // XIB : xml Interface Builder <= NIB
        searchTableView.register(UINib(nibName: ListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.identifier)
    }
    
    // MARK: - Custom Method

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        cell.titleLabel.font = .boldSystemFont(ofSize: 22)
        cell.titleLabel.text = "HELLOOOOOO"
        return cell
    }
}
