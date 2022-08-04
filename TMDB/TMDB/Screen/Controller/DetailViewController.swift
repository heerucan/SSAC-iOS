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
    var image: URL?
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
        requestCredit()
    }
    
    // MARK: - ConfigureUI
    
    func configureUI() {
        navigationItem.title = "출연/제작"
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.textColor = .white
        titleLabel.text = movieTitle
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.kf.setImage(with: image)
    }
    
    private func configureTableView() {
        detailTableView.register(UINib(nibName: OverviewTableViewCell.identifier, bundle: nil),
                                 forCellReuseIdentifier: OverviewTableViewCell.identifier)
        detailTableView.register(UINib(nibName: DetailTableViewCell.identifier, bundle: nil),
                                 forCellReuseIdentifier: DetailTableViewCell.identifier)
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.separatorStyle = .none
        detailTableView.backgroundColor = .white
    }
    
    // MARK: - Network
    
    private func requestCredit() {
        print(movieID)
        let url = EndPoint.castURL + "\(movieID)/credits?api_key=\(APIKey.movieKey)&language=en-US"

        AF.request(url, method: .get).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                                
                for crew in json["crew"].arrayValue {
                    let name = crew["name"].stringValue
                    let castName = crew["original_name"].stringValue
                    let character = crew["character"].stringValue
                    let image = URL(string: EndPoint.imageURL + crew["profile_path"].stringValue)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return posterImageView
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Overview"
        default: return "Cast"
        }
    }
    
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
