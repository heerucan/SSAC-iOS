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
    
    var genreString = ""

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
        navigationItem.backButtonTitle = nil
    }
    
    private func configureTableView() {
        searchTableView.register(UINib(nibName: SearchTableViewCell.identifier, bundle: nil),
                                 forCellReuseIdentifier: SearchTableViewCell.identifier)
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.backgroundColor = .white
        searchTableView.separatorStyle = .none
    }
    
    // MARK: - Network
    
    func requestGenre(genre: Int) {
        
        let genreURL = EndPoint.genreURL + "?api_key=\(APIKey.movieKey)&language=en-US"
        
        AF.request(genreURL, method: .get).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                                
                for i in json["genres"].arrayValue {
                    if genre == i["id"].intValue {
                        self.genreString = i["name"].stringValue
                        print(self.genreString, genre)
                    }
                }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let sb = UIStoryboard(name: Storyboard.main, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else { return }
        vc.image = movieList[indexPath.row].image
        vc.backImage = movieList[indexPath.row].backImage
        vc.movieTitle = movieList[indexPath.row].title
        vc.overview = movieList[indexPath.row].overview
        vc.movieID = movieList[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Network

extension SearchViewController {
    private func requestMovie() {
        MovieManager.shared.requestMovie { list in
            self.movieList.append(contentsOf: [list])
            DispatchQueue.main.async {
                self.searchTableView.reloadData()
            }
        }
    }
}
