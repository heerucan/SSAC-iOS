//
//  DiffableDataSourceViewController.swift
//  1617week
//
//  Created by heerucan on 2022/10/19.
//

import UIKit
import Kingfisher

final class DiffableDataSourceViewController: UIViewController {
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Property
    
    private var viewModel = DiffableViewModel()
    
    // 4. Int는 섹션에 대한 항목, String은 list 데이터가 들어갈 타입(모델에 들어갈 타입 자체)에 대한 항목
    private var dataSource: UICollectionViewDiffableDataSource<Int, SearchResult>!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = createLayout()
        configureDataSource()
        setupDelegate()
        bindData()
    }
    
    // MARK: - Bind
    
    private func bindData() {
        viewModel.photoList.bind { photo in
            // 6. snapshot 생성
            // 서버통신하면서 request 후 load되는데 시간이 걸리기 때문에
            var snapshot = NSDiffableDataSourceSnapshot<Int, SearchResult>()
            snapshot.appendSections([0])
            snapshot.appendItems(photo.results)
            self.dataSource.apply(snapshot)
        }
    }
    
    // MARK: - Custom Method
    
    private func setupDelegate() {
        collectionView.delegate = self
        searchBar.delegate = self
    }
}

extension DiffableDataSourceViewController: UICollectionViewDelegate {
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
    //        let alert = UIAlertController(title: item, message: "클릭", preferredStyle: .alert)
    //        let ok = UIAlertAction(title: "확인", style: .cancel)
    //        alert.addAction(ok)
    //        present(alert, animated: true)
    //    }
}

extension DiffableDataSourceViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //        var snapshot = dataSource.snapshot()
        //        snapshot.appendItems([searchBar.text!])
        //        dataSource.apply(snapshot, animatingDifferences: true)
        
        viewModel.requestSearchPhoto(query: searchBar.text!)
    }
}

// MARK: - Extension

extension DiffableDataSourceViewController {
    
    // 1. 컬렉션뷰 레이아웃 그리기
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    // 3. 셀에 데이터 넣기
    private func configureDataSource() {
        // 3-1. 셀 등록 초기화
        // 2. 셀 등록
        //        private var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, String>!
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, SearchResult>(handler: { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = "\(itemIdentifier.likes)"
            
            // kingfisher를 쓸 수 없음 왜내면 imageView.kf인데
            // content.image.kf니까...
            
            // String > URL > Data > Image 방식으로 바꿔줘야 한다.
            
            /*
             여기다가 하는 이유는,
             이 동작을 하는 동안 앱이 멈추지 않게 하기 위함
             메인에다가 하면 UI가 멈춰버려.
             */
            DispatchQueue.global().async {
                guard let url = URL(string: itemIdentifier.urls.thumb) else { return } // string -> url
                guard let data = try? Data(contentsOf: url) else { return } // url -> data
                
                // 근데 UI는 main thread에서 해야 하잖아?
                DispatchQueue.main.async {
                    content.image = UIImage(data: data) // data -> image : data 기반으로 이미지를 보여줄 수 있는 코드
                    cell.contentConfiguration = content // 얘는 왜 여기 있나? -> 이미지 로드가 되는 비동기적으로 되는 동안 코드가 실행되어버리기 때문에 이미지가 들어가기도 전에 끝나서..!! 중요함
                }
            }
            
            
            
            var backgroundConfiguration = UIBackgroundConfiguration.listPlainCell()
            backgroundConfiguration.strokeColor = .black
            backgroundConfiguration.strokeWidth = 2
            cell.backgroundConfiguration = backgroundConfiguration
        })
        
        // 5. dataSource 프로퍼티에 데이터 할당 like,, collectionView.dataSource = self 느낌
        // numberOfItemsInSection, cellForItemAt을 대체한다.
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: itemIdentifier)
            return cell
        })
    }
}
