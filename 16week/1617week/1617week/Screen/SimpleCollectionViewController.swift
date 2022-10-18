//
//  SimpleCollectionViewController.swift
//  1617week
//
//  Created by heerucan on 2022/10/18.
//

import UIKit

struct User {
    let name: String
    let company: String
    let age: Int
}

final class SimpleCollectionViewController: UICollectionViewController {
    
    //    var list = ["뿌링클", "달콤한맛팝콘", "치즈볼", "로제떡볶이"]
    var list = [
        User(name: "후리방구", company: "naver", age: 25),
        User(name: "소깡방구", company: "toss", age: 25),
        User(name: "태리야끼", company: "두나무", age: 26),
        User(name: "몽구방구", company: "naver", age: 23)
    ]
    
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, User>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 14+ 컬렉션뷰를 테이블뷰 스타일처럼 사용 가능 (List Configuration)
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        // collectionView의 속성도 여기서 설정해줄 수 있음
        configuration.showsSeparators = false
        configuration.backgroundColor = .systemPink
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        collectionView.collectionViewLayout = layout
        
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
            content.imageProperties.tintColor = .systemMint
            
            cell.contentConfiguration = content
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = list[indexPath.item]
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        
        return cell
    }
}
