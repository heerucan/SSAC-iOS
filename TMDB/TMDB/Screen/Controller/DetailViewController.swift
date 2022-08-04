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

final class DetailViewController: UIViewController {
    
    // MARK: - Property
    
    var movieID = 0
    var movieTitle = ""
    var image = ""
    var overview = ""
    
    // MARK: - @IBOutlet

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var detailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
    }
    
    // MARK: - ConfigureUI
    
    func configureUI() {
        navigationItem.title = "출연/제작"
        titleLabel.text = movieTitle
//        posterImageView.image = UIImage(named: image)
    }
    
    func configureTableView() {
        detailTableView.register(UINib(nibName: OverviewTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: OverviewTableViewCell.identifier)
        detailTableView.register(UINib(nibName: DetailTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DetailTableViewCell.identifier)
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.separatorStyle = .none
        detailTableView.backgroundColor = .white
    }
    
    func requestMovie() {
        let url = EndPoint.movieURL + "\(movieID)/credits?api_key=\(APIKey.movieKey)&language=en-US"
        
        
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        default: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier, for: indexPath) as? OverviewTableViewCell else { return UITableViewCell() }
            cell.overviewLabel.text = overview
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as? DetailTableViewCell else { return UITableViewCell() }
            
            return cell
        }
    }
}
