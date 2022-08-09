//
//  ContentViewController.swift
//  TMDB
//
//  Created by heerucan on 2022/08/10.
//

import UIKit

final class ContentViewController: UIViewController {
    
    // MARK: - Property
    
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
        configureTableView()
    }
    
    // MARK: - ConfigureUI
    
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
        return colorList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.identifier, for: indexPath) as? ContentCollectionViewCell
        else { return UICollectionViewCell() }
        cell.posterView.backgroundColor = colorList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 10 + 10 + 20 + 120
    }
}
