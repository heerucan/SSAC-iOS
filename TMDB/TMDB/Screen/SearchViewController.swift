//
//  SearchViewController.swift
//  TMDB
//
//  Created by heerucan on 2022/08/03.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Property
    
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var searchTableView: UITableView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - configureUI
    
    private func configureUI() {
        view.backgroundColor = .clear
    }
    
    private func configureTableView() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }

    // MARK: - Custom Method

}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        return cell
    }
}
