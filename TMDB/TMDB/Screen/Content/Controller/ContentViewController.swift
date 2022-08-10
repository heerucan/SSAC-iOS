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
    private let pageNumber = 1
    
    var posterList: [String] = []
    
    let colorList: [UIColor] = [.systemPink, .systemOrange, .systemYellow, .systemGreen, .systemPurple]
    
    let categoryList = ["인기 콘텐츠",
                        "우영우와 비슷한 콘텐츠",
                        "액션 SF",
                        "미국 TV 프로그램",
                        "비포선라이즈와 비슷한 영화",
                        "박은빈이 나오는 한국 영화",
                        "해리포터 시리즈 몰아보기"]
    
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
        navigationItem.title = "추천 및 비슷한 콘텐츠"
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
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCell.identifier, for: indexPath) as? ContentTableViewCell
        else { return UITableViewCell() }
        cell.categoryLabel.text = categoryList[indexPath.row]
        cell.contentCollectionView.delegate = self
        cell.contentCollectionView.dataSource = self
        cell.contentCollectionView.register(
            UINib(nibName: Nib.content, bundle: nil),
            forCellWithReuseIdentifier: ContentCollectionViewCell.identifier)
        return cell
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension ContentViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posterList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.identifier, for: indexPath) as? ContentCollectionViewCell
        else { return UICollectionViewCell() }
        let url = URL(string: posterList[indexPath.item])
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
            self.posterList = list
            DispatchQueue.main.async {
                self.contentTableView.reloadData()
            }
        }
    }
}
