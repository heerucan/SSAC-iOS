//
//  SimpleCollectionViewController.swift
//  1617week
//
//  Created by heerucan on 2022/10/18.
//

import UIKit

struct User: Hashable {
    let id = UUID().uuidString
    let name: String
    let company: String
    let age: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
}

final class SimpleCollectionViewController: UICollectionViewController {
    
    // MARK: - Property
    
    //    var list = ["뿌링클", "달콤한맛팝콘", "치즈볼", "로제떡볶이"]
    var list = [
        User(name: "후리방구", company: "naver", age: 25),
        User(name: "소깡방구", company: "toss", age: 25),
        User(name: "태리야끼", company: "두나무", age: 26),
        User(name: "후리구", company: "naver", age: 25),
        User(name: "소깡구", company: "toss", age: 25),
        User(name: "태리야끼", company: "두나무", age: 26),
        User(name: "몽구방구", company: "naver", age: 23),
        User(name: "후구", company: "naver", age: 25),
        User(name: "소구", company: "toss", age: 25),
        User(name: "태끼", company: "두나무", age: 26),
        User(name: "몽구", company: "naver", age: 23),
        User(name: "구", company: "naver", age: 23)
    ]
    
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, User>!
    
    var dataSource: UICollectionViewDiffableDataSource<Int, User>!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = createLayout()
        
        // cellRegistration 초기화
        /*
         cell : 어떤 컬렉션뷰 셀을 쓸 거냐?
         indexPath : 각각의 셀의 인덱스패스에 대한 정보
         itemIdentifier : 들어올 데이터
         */
        cellRegistration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell() // cell.defaultContentConfiguration()
            content.text = itemIdentifier.name + "💚 \(itemIdentifier.company)"
            content.textProperties.color = .systemGreen
            
            content.secondaryText = "우리취업뽀개보쟈!!!"
            content.secondaryTextProperties.color = .systemBlue
            content.prefersSideBySideTextAndSecondaryText = false
            content.textToSecondaryTextVerticalPadding = 20
            
            // content.image = indexPath.item % 2 == 0 ? UIImage(systemName: "heart.fill") : UIImage(systemName: "star.fill")
            
            content.image = itemIdentifier.age % 2 == 0 ? UIImage(systemName: "heart.fill") : UIImage(systemName: "star.fill")
            
            if indexPath.item < 2 {
                content.imageProperties.tintColor = .systemMint
            } else {
                content.imageProperties.tintColor = .systemOrange
            }
            
            
            cell.contentConfiguration = content
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .darkGray
            backgroundConfig.cornerRadius = 10
            backgroundConfig.strokeWidth = 2
            backgroundConfig.strokeColor = .black
            cell.backgroundConfiguration = backgroundConfig
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: self.cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, User>()
        snapshot.appendSections([0])
        snapshot.appendItems(list)
        dataSource.apply(snapshot)
    }
    
    // MARK: - UICollectionView Delegate / DataSource
    // Diffable을 사용한다면 쓰지 않음
    //    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //        return list.count
    //    }
    //
    //    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //
    //        let item = list[indexPath.item]
    //        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
    //        return cell
    //    }
}

// MARK: - CompositionalLayout

extension SimpleCollectionViewController {
    private func createLayout() -> UICollectionViewLayout {
        // 14+ 컬렉션뷰를 테이블뷰 스타일처럼 사용 가능 (List Configuration)
        // 컬렉션 뷰 셀과는 관련이 없는 컬렉션뷰 스타일과 관련된 아이임
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        // collectionView의 속성도 여기서 설정해줄 수 있음
        configuration.showsSeparators = false
        configuration.backgroundColor = .systemPink
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        collectionView.collectionViewLayout = layout
        return layout
    }
}
