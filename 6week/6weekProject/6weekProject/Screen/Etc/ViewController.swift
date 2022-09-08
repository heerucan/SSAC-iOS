//
//  ViewController.swift
//  6weekProject
//
//  Created by heerucan on 2022/08/08.
//

import UIKit

import Kingfisher
import SwiftyJSON

/*
 1. html tag <> </> 기능 활용
 2. 문자열을 대체할 수 있는 메서드 사용
 */

/*
 TableView AutomaticDimension
 
 - 컨텐츠 양에 따라서 셀 높이가 자유롭게
 - 조건 : 레이블 numberOfLines = 0
 - 조건 : tableView.
 - 조건 : 레이아웃
 
 테이블 뷰의 프로토콜 메소드가 프로퍼티보다 더 우선한다.
 */

class ViewController: UIViewController {
    
    private var blogList: [String] = []
    private var cafeList: [String] = []
    
    private var isExpanded = false // false면 2줄, true면 0줄
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        requestShoppingList(query: "spao")
//        searchBlog(keyword: "Swift")
        let user = User()
        user.nickname
    }
    
    @IBAction func expandCell(_ sender: UIBarButtonItem) {
        isExpanded = !isExpanded
        tableView.reloadData()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension // 모든 섹션 셀에 대해 유동적
    }
    
    func requestShoppingList(query: String) {
        ClovaAPIManager.shared.getImage(query: query) { json in
            print(json[0])
        }
    }

    
    func searchBlog(keyword: String) {
        KakaoAPIManager.shared.callRequest(.blog, query: keyword) { json in
            let value = json["documents"].arrayValue.map { $0["contents"].stringValue
                    .replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "") }
            self.blogList.append(contentsOf: value)
            self.searchCafe(keyword: "Nct")
        }
    }
    
    func searchCafe(keyword: String) {
        KakaoAPIManager.shared.callRequest(.blog, query: keyword) { json in
            let value = json["documents"].arrayValue.map { $0["contents"].stringValue
                    .replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "") }
            self.cafeList.append(contentsOf: value)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? blogList.count : cafeList.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "블로그 검색 결과" : "카페 검색 결과"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KakaoTableViewCell.identifier, for: indexPath) as? KakaoTableViewCell else { return UITableViewCell() }
        cell.testLabel.numberOfLines = isExpanded ? 0 : 2
        cell.testLabel.text = indexPath.section == 0 ? blogList[indexPath.row] : cafeList[indexPath.row]
        return cell
    }
}

class KakaoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var testLabel: UILabel!
}
