//
//  DetailViewController.swift
//  TMDB
//
//  Created by heerucan on 2022/08/05.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON
import SwiftUI

final class DetailViewController: UIViewController {
    
    // MARK: - Property
    
    var movieID = 0
    var movieTitle = ""
    var image: URL?
    var overview = ""
    
    var castList: [Cast] = []
    
    // MARK: - @IBOutlet

    @IBOutlet weak var detailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        requestCredit()
    }
    
    // MARK: - ConfigureUI
    
    func configureUI() {
        navigationItem.title = "출연/제작"
    }
    
    private func configureTableView() {
        detailTableView.register(UINib(nibName: OverviewTableViewCell.identifier, bundle: nil),
                                 forCellReuseIdentifier: OverviewTableViewCell.identifier)
        detailTableView.register(UINib(nibName: DetailTableViewCell.identifier, bundle: nil),
                                 forCellReuseIdentifier: DetailTableViewCell.identifier)
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.backgroundColor = .white
        detailTableView.sectionHeaderTopPadding = 0
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let headerView = DetailHeaderView()
            headerView.titleLabel.text = movieTitle
            headerView.posterImageView.kf.setImage(with: image)
            headerView.backImageView.kf.setImage(with: image)
            return headerView
        case 1:
            let textView = DetailTextHeaderView()
            textView.title = "OverView"
            return textView
        case 2:
            let textView = DetailTextHeaderView()
            textView.title = "Cast"
            return textView
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0: return 150
        default: return 40
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1: return 1
        case 2: return castList.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: return UITableViewCell()
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier, for: indexPath) as? OverviewTableViewCell else { return UITableViewCell() }
            cell.overviewLabel.text = overview
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as? DetailTableViewCell else { return UITableViewCell() }
            cell.setData(data: castList[indexPath.row])
            return cell
        }
    }
}

// MARK: - Network

extension DetailViewController {
    private func requestCredit() {
        CreditManager.shared.requestCredit(movieID: movieID) { list in
            self.castList.append(contentsOf: [list])
            DispatchQueue.main.async {
                self.detailTableView.reloadData()
            }
        }
    }
}
