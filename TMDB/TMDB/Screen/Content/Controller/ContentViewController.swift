//
//  ContentViewController.swift
//  TMDB
//
//  Created by heerucan on 2022/08/10.
//

import UIKit

import Kingfisher

final class ContentViewController: UIViewController {
    
    // MARK: - Property
    
    public var movieID = 0
    private var posterList: [[String]] = [[]]
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var contentTableView: UITableView!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        requestSimilarMovie()
    }
    
    // MARK: - ConfigureUI
    
    private func configureUI() {
        navigationItem.title = "Similar Contents"
        navigationController?.navigationBar.tintColor = .black
    }
    
    func configureTableView() {
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.separatorStyle = .none
        contentTableView.showsHorizontalScrollIndicator = false
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ContentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCell.identifier,
                                                       for: indexPath) as? ContentTableViewCell
        else { return UITableViewCell() }
        cell.categoryLabel.text = "\(indexPath.row+1)번째 추천 콘텐츠"
        cell.contentCollectionView.tag = indexPath.row
        cell.contentCollectionView.delegate = self
        cell.contentCollectionView.dataSource = self
        cell.contentCollectionView.register(
            UINib(nibName: Nib.content, bundle: nil),
            forCellWithReuseIdentifier: ContentCollectionViewCell.identifier)
        cell.contentCollectionView.reloadData()
        return cell
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension ContentViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posterList[collectionView.tag].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.identifier,
                                                            for: indexPath) as? ContentCollectionViewCell
        else { return UICollectionViewCell() }
        let url = URL(string: posterList[collectionView.tag][indexPath.item])
        cell.posterView.posterImageView.kf.setImage(with: url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 10 + 10 + 20 + 120
    }
}

// MARK: - Network

extension ContentViewController {
    func requestSimilarMovie() {
        MovieManager.shared.requestSimilarMovie(movieID: movieID, pageNumber: 1) { list in
            self.posterList.append(list)
            MovieManager.shared.requestSimilarMovie(movieID: self.movieID, pageNumber: 2) { list in
                self.posterList.append(list)
                MovieManager.shared.requestSimilarMovie(movieID: self.movieID, pageNumber: 3) { list in
                    self.posterList.append(list)
                    MovieManager.shared.requestSimilarMovie(movieID: self.movieID, pageNumber: 4) { list in
                        self.posterList.append(list)
                        MovieManager.shared.requestSimilarMovie(movieID: self.movieID, pageNumber: 5) { list in
                            self.posterList.append(list)
                            DispatchQueue.main.async {
                                self.contentTableView.reloadData()
                            }
                            self.posterList.removeFirst()
                        }
                    }
                }
            }
        }
    }
}
