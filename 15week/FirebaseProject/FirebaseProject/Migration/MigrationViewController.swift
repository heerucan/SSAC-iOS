//
//  MigrationViewController.swift
//  FirebaseProject
//
//  Created by heerucan on 2022/10/13.
//

import UIKit

import RealmSwift

final class MigrationViewController: UIViewController {
    
    // MARK: - Realm
    
    let localRealm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. fileURL
        print("FileURL: \(localRealm.configuration.fileURL)")
        
        // 2. Schema Version 체크
        do {
            let version = try schemaVersionAtURL(localRealm.configuration.fileURL!)
            print("스키마 버전", version)
        } catch {
            print(error)
        }
        
        // 3. Test를 위한 데이터 추가
        for i in 1...100 {
            let task = Todo(title: "몽구방구의 할 일 \(i)", importance: Int.random(in: 1...5))

            try! localRealm.write {
                localRealm.add(task)
            }
        }
    }


}
