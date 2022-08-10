//
//  CardViewController.swift
//  6weekProject
//
//  Created by heerucan on 2022/08/09.
//

import UIKit

import Kingfisher

class CardViewController: UIViewController {
    
    // MARK: - Property
    
    let color: [UIColor] = [.systemPurple, .systemOrange, .systemYellow, .systemGreen]
    let numberList: [[Int]] = [
        [Int](100...110),
        [Int](55...75),
        [Int](5000...5006),
        [Int](31...40),
        [Int](51...60),
        [Int](81...90)
    ]
    
    var categoryList: [[String]] = [[]]
    var episodeList: [[String]] = [[]]

    // MARK: - @IBOutlet

    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var mainTableView: UITableView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureTableView()
        requestEpisode()
    }
    
    // MARK: - ConfigureUI
    
    func configureCollectionView() {
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        bannerCollectionView.register(UINib(nibName: CardCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
        bannerCollectionView.isPagingEnabled = true
        bannerCollectionView.collectionViewLayout = collectionViewLayout()
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let width = UIScreen.main.bounds.width
        let height = bannerCollectionView.frame.height
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets.zero
        return layout
    }
    
    func configureTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension CardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == bannerCollectionView ? color.count : episodeList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.identifier, for: indexPath) as? CardCollectionViewCell else { return UICollectionViewCell() }
        if collectionView == bannerCollectionView {
            cell.cardView.posterImageView.backgroundColor = color[indexPath.item]
        } else {
            cell.cardView.contentLabel.text = ""
            cell.cardView.posterImageView.backgroundColor = collectionView.tag.isMultiple(of: 2) ? .white : .yellow
            let url = URL(string: episodeList[collectionView.tag][indexPath.item])
            cell.cardView.posterImageView.kf.setImage(with: url)
            
            // 화면과 데이터는 별개, 모든 indexPath.item에 대한 조건이 없다면 재사용 시 오류가 발생할 수 있다.
//            if indexPath.item < 2 {
//                cell.cardView.contentLabel.text = "\(numberList[collectionView.tag][indexPath.item])"
//            } else {
//                cell.cardView.contentLabel.text = "Happy"
//            }
        }
        return cell
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension CardViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return episodeList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardTableViewCell.identifier, for: indexPath) as? CardTableViewCell else { return UITableViewCell() }
        cell.titleLabel.text = TMDBAPIManager.shared.tvList[indexPath.section].0
        cell.contentCollectionView.tag = indexPath.section // 각 셀 구분 짓기
        cell.contentCollectionView.delegate = self
        cell.contentCollectionView.dataSource = self
        cell.contentCollectionView.register(
            UINib(nibName: CardCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
        cell.contentCollectionView.reloadData() // index out of range 오류를 해결할 수 있다.
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
}

// MARK: - Network

extension CardViewController {
    func requestEpisode() {
        TMDBAPIManager.shared.requestImage { value in
            // 1. 네트워크 통신 2. 배열 생성 3. 배열 담기
            // 4. 뷰에 표현 5. 뷰 갱신
            self.episodeList = value
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
        }
    }
}
