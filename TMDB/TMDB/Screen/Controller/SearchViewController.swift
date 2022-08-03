//
//  SearchViewController.swift
//  TMDB
//
//  Created by heerucan on 2022/08/03.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

final class SearchViewController: UIViewController {

    // MARK: - Property
    
    var movieList: [Movie] = []
    
    let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "list.triangle"),
                                     style: .plain,
                                     target: self,
                                     action: #selector(touchupLeftButton))
    
    let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"),
                                      style: .plain,
                                      target: self,
                                      action: #selector(touchupRightButton))
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var searchTableView: UITableView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        requestMovie()
    }
    
    // MARK: - configureUI
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    private func configureTableView() {
        searchTableView.register(UINib(nibName: SearchTableViewCell.identifier, bundle: nil),
                                 forCellReuseIdentifier: SearchTableViewCell.identifier)
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.backgroundColor = .white
        searchTableView.separatorStyle = .none
        searchTableView.allowsSelection = false
    }
    
    // MARK: - Network
    
    private func requestMovie() {
        let url = EndPoint.movieURL + "?api_key=\(APIKey.movieKey)"
    
        AF.request(url, method: .get).validate(statusCode: 200...500).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for movie in json["results"].arrayValue {
                    
                    let title = movie["title"].stringValue
                    let poster = movie["poster_path"].stringValue
                    let rate = movie["vote_average"].doubleValue
                    let overview = movie["overview"].stringValue
                    let date = movie["release_date"].stringValue
                    
                    let data = Movie(title: title,
                                     date: date,
                                     genre: "#Movie",
                                     image: poster,
                                     overview: overview,
                                     rate: rate)
                    
                    self.movieList.append(data)
                }
                self.searchTableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - @objc
    
    @objc func touchupLeftButton() { }
    @objc func touchupRightButton() { }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        cell.setData(data: movieList[indexPath.row])
        return cell
    }
}
