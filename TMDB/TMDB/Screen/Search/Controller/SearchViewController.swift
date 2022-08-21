//
//  SearchViewController.swift
//  TMDB
//
//  Created by heerucan on 2022/08/03.
//

import UIKit

import Alamofire
import HureeUIFrameWork
import Kingfisher
import SwiftyJSON

final class SearchViewController: UIViewController {

    // MARK: - Property
    
    var pageNumber = 1
    var movieList: [Movie] = []
    var genreList: [Genre] = []
    
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
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        requestMovie(pageNumber: pageNumber)
        requestGenre()
    }
    
    // MARK: - configureUI
    
    private func configureUI() {
        UserDefaults.standard.set(false, forKey: Key.first.rawValue)
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func configureTableView() {
        searchTableView.register(UINib(nibName: SearchTableViewCell.reuseIdentifier, bundle: nil),
                                 forCellReuseIdentifier: SearchTableViewCell.reuseIdentifier)
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.prefetchDataSource = self
        searchTableView.backgroundColor = .white
        searchTableView.separatorStyle = .none
    }
    
    // MARK: - @objc
    
    @objc func touchupLeftButton() {
        transitionViewController(
            storyboard: Storyboard.main,
            viewController: LocationViewController(),
            transitionStyle: .push)
    }
    
    @objc func touchupRightButton() { }
    
    @objc func touchupLinkButton(_ sender: UIButton) {
        transitionViewController(
            storyboard: Storyboard.main,
            viewController: WebViewController(),
            transitionStyle: .present) { vc in
                vc.movieID = self.movieList[sender.tag].id
            }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        let genreID = movieList[indexPath.row].genre
        for movie in self.genreList {
            if movie.id == genreID {
                cell.tagLabel.text = "#\(movie.genre)"
            }
        }
        cell.setData(data: movieList[indexPath.row])
        cell.linkButton.tag = indexPath.row
        cell.linkButton.addTarget(self, action: #selector(touchupLinkButton(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        transitionViewController(
            storyboard: Storyboard.main,
            viewController: DetailViewController(),
            transitionStyle: .push) { vc in
                vc.setupData(data: self.movieList[indexPath.row])
            }
    }
}

// MARK: - UITableViewDataSourcePrefetching

extension SearchViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            // 항상 인덱스는 0부터 시작하니까 전체 개수에서 1을 빼줘야 똑같아짐
            if movieList.count - 1 == indexPath.row && indexPath.row < movieList.count {
                pageNumber += 10
                requestMovie(pageNumber: pageNumber)
            }
        }
    }
}

// MARK: - Network

extension SearchViewController {
    private func requestMovie(pageNumber: Int) {
        MovieManager.shared.requestMovie(pageNumber: pageNumber) { list in
            self.movieList.append(contentsOf: list)
            DispatchQueue.main.async {
                self.searchTableView.reloadData()
            }
        }
    }
    
    private func requestGenre() {
        MovieManager.shared.requestGenre { list in
            self.genreList.append(contentsOf: list)
        }
    }
}

