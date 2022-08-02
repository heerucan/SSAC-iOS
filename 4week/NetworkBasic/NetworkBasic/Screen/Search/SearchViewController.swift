//
//  SearchViewController.swift
//  NetworkBasic
//
//  Created by heerucan on 2022/07/27.
//

import UIKit

import Alamofire
import SwiftyJSON

/*
 Swift Protocol
 - Delegate
 - DataSource
 */

/*
 각 json value -> list -> 테이블 갱신
 
 let movieNm1 = json["boxOfficeResult"]["dailyBoxOfficeList"][0]["movieNm"].stringValue
 let movieNm2 = json["boxOfficeResult"]["dailyBoxOfficeList"][1]["movieNm"].stringValue
 let movieNm3 = json["boxOfficeResult"]["dailyBoxOfficeList"][2]["movieNm"].stringValue
 
 self.boxOfficeList.append(movieNm1)
 self.boxOfficeList.append(movieNm2)
 self.boxOfficeList.append(movieNm3)
 
  서버의 값이 몇 개인지 모를 경우에는? -> for 문을 통해서 가능하고 그 경우 구조체로 모델 생성
 */

final class SearchViewController: UIViewController {
    
    var boxOfficeList: [BoxOfficeModel] = []

    // MARK: - Properties
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        requestBoxOffice(text: calculateDate())
    }
    
    // MARK: - InitUI
    
    private func configureUI() {
        searchBar.delegate = self
    }
    
    private func configureTableView() {
        // 연결고리 작업 : 테이블뷰가 해야 할 역할 > 뷰 컨트롤러에게 요청
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        // 테이블뷰가 사용할 테이블뷰 셀(XIB) 등록 작업
        // XIB : xml Interface Builder <= NIB
        searchTableView.register(UINib(nibName: ListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.identifier)
    }
    
    // MARK: - Custom Method
    
    func calculateDate() -> String {
        let now = Date()
        let yesterday = now.addingTimeInterval(-86400)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let date = formatter.string(from: yesterday)
        return date
    }
    
    func requestBoxOffice(text: String) {
        
        // 서버 요청 시에 배열에 데이터를 지워줘야 새로운 데이터를 담을 수 있어 보기 좋다.
        boxOfficeList.removeAll()
                
        let url = "\(EndPoint.boxOfficeURL)?key=\(APIKey.MOVIE_KEY)&targetDt=\(text)"

        AF.request(url, method: .get).validate(statusCode: 200..<400).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for movie in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    let movieNm = movie["movieNm"].stringValue
                    let audiCnt = movie["audiCnt"].stringValue
                    let openDt = movie["openDt"].stringValue
                    
                    let data = BoxOfficeModel(movieTitle: movieNm, releaseDate: openDt, totalCount: audiCnt)
                    self.boxOfficeList.append(data)
                }
                self.searchTableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boxOfficeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        cell.titleLabel.font = .boldSystemFont(ofSize: 15)
        cell.titleLabel.text = "\(boxOfficeList[indexPath.row].movieTitle) | \(boxOfficeList[indexPath.row].releaseDate)"
        return cell
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        requestBoxOffice(text: searchText)
    }
}
