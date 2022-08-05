//
//  ImageSearchViewController.swift
//  NetworkBasic
//
//  Created by heerucan on 2022/08/03.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

final class ImageSearchViewController: UIViewController {
    
    // MARK: - Property
    
    // 네트워크 요청할 페이지 넘버
    var startPage = 1
    var totalCount = 0
    
    var imageList: [String] = []
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        configureUI()
        setupSearchBar()
    }
    
    // MARK: - ConfigureUI
    
    func configureUI() {
        let width = UIScreen.main.bounds.width / 3
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: width, height: width)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        imageCollectionView.collectionViewLayout = layout
    }
    
    func setupCollectionView() {
        imageCollectionView.register(UINib(nibName: ImageSearchCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ImageSearchCollectionViewCell.identifier)
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.prefetchDataSource = self
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
    }
    
    // MARK: - Network
    
    func fetchImage(query: String) {
        // 파라미터 부분은 값을 전달받는 것이고, 클로저부분은 값을 빼오는 것
        ImageSearchAPIManager.shared.fetchImageData(query: query, startPage: startPage) { totalCount, list in
            self.totalCount = totalCount
            self.imageList.append(contentsOf: list)
            self.imageCollectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource

extension ImageSearchViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageSearchCollectionViewCell.identifier, for: indexPath) as? ImageSearchCollectionViewCell else { return UICollectionViewCell() }
        cell.imageView.kf.setImage(with: URL(string: imageList[indexPath.item]))
        return cell
    }
    
    // 페이지네이션 방법1. 컬렉션뷰가 특정 셀을 그리려는 시점에 호출되는 메서드.
    // 마지막 셀에 사용자가 위치해있는지 명확하게 확인하기 어려움
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//
//    }
    
    // 페이지네이션 방법2. UIScrollViewDelegateProtocol
    // 테이블뷰/컬렉션뷰는 스크롤뷰를 상속받고 있어서, 스크롤뷰 프로토콜을 사용할 수 있음.
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset)
//    }
}

// 페이지네이션 방법3. 용량이 큰 이미지를 다운받아 셀에 보여주려고 하는 경우에 효과적.
// 셀이 화면에 보이기 전에 미리 필요한 리소스를 다운받을 수 있고, 필요하지 않다면 데이터를 취소할 수도 있음
// iOS10 이상, 스크롤 성능 향상됨
extension ImageSearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if imageList.count - 1 == indexPath.item && imageList.count < totalCount {
                startPage += 30
                guard let text = searchBar.text else { return }
                fetchImage(query: text)
            }
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
//        print("########",indexPaths)
//    }
}

extension ImageSearchViewController: UISearchBarDelegate {
    
    // 검색 버튼 클릭 시 실행
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            // 검색 버튼을 누를 경우에 초기화시켜줘야 하기 때문
            imageList.removeAll()
            startPage = 1
            fetchImage(query: text)
            if !imageList.isEmpty {
                imageCollectionView.scrollsToTop = true
//                imageCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            }
        }
        
    }
    
    // 취소 버튼 눌렀을 때 실행
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        imageList.removeAll()
        imageCollectionView.reloadData()
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    // 서치바에 커서가 깜빡이기 시작할 때 실행
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
}
