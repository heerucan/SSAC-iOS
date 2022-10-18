//
//  SampleCollectionViewController.swift
//  FirebaseProject
//
//  Created by heerucan on 2022/10/18.
//

import UIKit

import RealmSwift

final class SampleCollectionViewController: UICollectionViewController {
    
    // MARK: - Realm
    
    var tasks: Results<Todo>!
    let localRealm = try! Realm()
    
    // 2.
    var cellRegisteration: UICollectionView.CellRegistration<UICollectionViewListCell, Todo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasks = localRealm.objects(Todo.self) // realm에서 데이터 가져오기
        

        
        // 1.
        let configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        // UICollectionViewCompositionalLayout은 UICollectionViewLayout를 상속받고 있음
        collectionView.collectionViewLayout = layout // UICollectionViewLayout
        
        // 3. cellType, cell IndexPath, cell에 들어갈 데이터
        cellRegisteration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            var content = cell.defaultContentConfiguration()
            content.image = itemIdentifier.importance < 2 ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
            content.text = itemIdentifier.title
            content.secondaryText = "\(itemIdentifier.detail.count)개의 세부항목"
            
            cell.contentConfiguration = content
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = tasks[indexPath.item]
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: item)
        
        // 타입으로서의 프로토콜
        // 타입 자체를 프로토콜로 선언을 해버리면, 클래스 제약에도 벗어나고, 구조체/열거형 제약에도 벗어나서 어떤 객체든지 값 전달이 가능하다.
        var test: fruit = apple()
        test = banana()
        test = melon()
        return cell
    }
    
}

// 클래스 간에 상속만 잘해주면 클래스가 달라도 값을 넣어줄 수 있음

class food {
    
}

protocol fruit {
    
}

class apple: food, fruit {
    
}

class banana: food, fruit {
    
}

// 구조체나 열거형은 애초에 상속이 안되는데 food의 속성을 주고 싶은 경우는 어떻게 하나?
// 이때 프로토콜 개념이 등장

enum strawberry: fruit {
    
}

struct melon: fruit {

}

/*
 let tv = UITableView()
 tv.delegate = self
 tv.dataSource = self
 */
// 근데 self는 클래스의 인스턴스고, delegate는 프로토콜을 타입으로 가지고 있는 프로퍼티임
// 결국 프로토콜로서 값을 전달할 수 있었던 것임.

