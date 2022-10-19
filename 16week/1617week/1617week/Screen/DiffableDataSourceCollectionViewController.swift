//
//  DiffableDataSourceViewController.swift
//  1617week
//
//  Created by heerucan on 2022/10/19.
//

import UIKit

final class DiffableDataSourceViewController: UIViewController {
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Property
    
    private var list = ["루희", "후리", "후리방구", "히루", "뤃", "루루", "루똥이"]
    
    // 4. Int는 섹션에 대한 항목, String은 list 데이터가 들어갈 타입(모델에 들어갈 타입 자체)에 대한 항목
    private var dataSource: UICollectionViewDiffableDataSource<Int, String>!

    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = createLayout()
        configureDataSource()
        setupSearchBar()
        collectionView.delegate = self
    }
    
    // MARK: - Custom Method
    
    func setupSearchBar() {
        searchBar.delegate = self
    }
}

extension DiffableDataSourceViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        let alert = UIAlertController(title: item, message: "클릭", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}

extension DiffableDataSourceViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems([searchBar.text!])
        dataSource.apply(snapshot, animatingDifferences: true)
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
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String>(handler: { cell, indexPath, itemIdentifier in
            
            var contentConfiguration = UIListContentConfiguration.valueCell()
            contentConfiguration.text = itemIdentifier
            contentConfiguration.secondaryText = "\(itemIdentifier.count)"
            cell.contentConfiguration = contentConfiguration
            
            var backgroundConfiguration = UIBackgroundConfiguration.listPlainCell()
            backgroundConfiguration.strokeColor = .systemOrange
            backgroundConfiguration.strokeWidth = 2
            cell.backgroundConfiguration = backgroundConfiguration
        })
        
        // 5. dataSource 프로퍼티에 데이터 할당 like,, collectionView.dataSource = self 느낌
        // numberOfItemsInSection, cellForItemAt을 대체한다.
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            
            return cell
        })
        
        func performQuery(filter: String?) {
            
            // 6. snapshot 생성
            var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
            snapshot.appendSections([0])
            snapshot.appendItems(list)
            dataSource.apply(snapshot)
        }
        
        // 6. snapshot 생성
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(list)
        dataSource.apply(snapshot)
    }
}
