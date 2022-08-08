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
    
    var isExpand = false
    var movieID = 0
    var movieTitle = ""
    var image: URL?
    var backImage: URL?
    var overview = ""
    
    private var castList: [Cast] = []
    private var crewList: [Crew] = []
        
    // MARK: - @IBOutlet

    @IBOutlet weak var detailTableView: UITableView!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        requestCredit()
    }
    
    // MARK: - ConfigureUI
    
    private func configureUI() {
        navigationItem.title = "출연/제작"
        navigationController?.navigationBar.tintColor = .black
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
        detailTableView.allowsSelection = false
    }
    
    // MARK: - Custom Method
    
    public func setupData(data: Movie) {
        image = data.image
        backImage = data.backImage
        movieTitle = data.title
        overview = data.overview
        movieID = data.id
    }
    
    // MARK: - @objc
    
    @objc func touchupDownButton(_ sender: UIButton) {
        isExpand = !isExpand
        self.detailTableView.reloadData()
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
            headerView.backImageView.kf.setImage(with: backImage)
            return headerView
        case 1, 2, 3:
            let textView = DetailTextHeaderView()
            textView.title = textView.headerList[section-1]
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
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1: return 1
        case 2: return castList.count
        case 3: return crewList.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier, for: indexPath) as? OverviewTableViewCell else { return UITableViewCell() }
            cell.overviewLabel.text = overview
            cell.isExpand = isExpand
            cell.configureUI()
            cell.downButton.addTarget(self, action: #selector(touchupDownButton(_:)), for: .touchUpInside)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as? DetailTableViewCell else { return UITableViewCell() }
            cell.setCastData(data: castList[indexPath.row])
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as? DetailTableViewCell else { return UITableViewCell() }
            cell.setCrewData(data: crewList[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - Network

extension DetailViewController {
    private func requestCredit() {
        CreditManager.shared.requestCredit(movieID: movieID) { castList, crewList in
            self.castList = castList
            self.crewList = crewList
            DispatchQueue.main.async {
                self.detailTableView.reloadData()
            }
        }
    }
}
