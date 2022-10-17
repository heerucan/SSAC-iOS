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
    
    var tasks: Results<Todo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // MARK: - 1. fileURL
        print("FileURL: \(String(describing: localRealm.configuration.fileURL))")
        
        
        // MARK: - 2. Schema Version 체크
        do {
            let version = try schemaVersionAtURL(localRealm.configuration.fileURL!)
            print("스키마 버전", version)
        } catch {
            print(error)
        }
        
        
        // MARK: - 3. Test를 위한 데이터 추가
        //        for i in 1...100 {
        //            let task = Todo(title: "몽구방구의 할 일 \(i)", importance: Int.random(in: 1...5))
        //
        //            try! localRealm.write {
        //                localRealm.add(task)
        //            }
        //        }
        
        
        // MARK: -  4. 특정 Todo 테이블에 Detail Todo를 위한 데이터 추가
        //        for i in 1...10 {
        //            let task = DetailTodo(detailTitle: "비타민\(i)개 먹기", favorite: true)
        //
        //            try! localRealm.write {
        //                localRealm.add(task)
        //            }
        //        }
        
        
        // MARK: - 5. 특정 Todo 테이블에 DetailTodo 추가
        //        guard let task = localRealm.objects(Todo.self).filter("title = '몽구방구의 할 일 7'").first $else { return }
        //
        //        let detail = DetailTodo(detailTitle: "안과가기", favorite: false)
        //        try! localRealm.write {
        //            task.detail.append(detail)
        //        }
        //
        //        print("✴️", task)
        
        //        guard let task = localRealm.objects(Todo.self).filter("title = '몽구방구의 할 일 3'").first else { return }
        //
        //        let detail = DetailTodo(detailTitle: "호캉스가기💛", favorite: false)
        //
        //        for _ in 1...5 {
        //            try! localRealm.write {
        //                task.detail.append(detail)
        //            }
        //        }
        //        print("✴️", task)
        
        
        // MARK: - 특정 Todo, DetailTodo 테이블 삭제
        //        guard let task = localRealm.objects(Todo.self).filter("title = '몽구방구의 할 일 3'").first else { return }
        //
        //        try! localRealm.write {
        //            localRealm.delete(task.detail)
        //            localRealm.delete(task)
        //        }
        
        
        // MARK: - 특정 Todo 메모추가
        guard let task = localRealm.objects(Todo.self).filter("title = '몽구방구의 할 일 6'").first else { return }
        
        let memo = Memo()
        memo.content = "몽구방구 안과를 가야 합니당"
        memo.date = Date()
        
        try! localRealm.write {
            task.memo = memo
        }
        
        let detailTask = localRealm.objects(DetailTodo.self).sorted(byKeyPath: "detailTitle")
        print("✴️", detailTask)
    }
}
