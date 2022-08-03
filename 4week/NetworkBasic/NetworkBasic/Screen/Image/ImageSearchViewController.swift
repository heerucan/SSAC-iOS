//
//  ImageSearchViewController.swift
//  NetworkBasic
//
//  Created by heerucan on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON

final class ImageSearchViewController: UIViewController {

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
    }
    
    // MARK: - Network
    
    func fetchImage() {
        
        // 한글이 안되는 경우 : utf-8로 인코딩 하기 때문에 내부 처리가 필요함
        guard let text = "우영우".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = EndPoint.imageSearchURL + "query=\(text)&display=30&start=31"
        
        // Header : 메타정보
        // Body : 실질적인 데이터
        
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.NAVER_SEARCH_ID,
            "X-Naver-Client-Secret": APIKey.NAVER_SEARCH_KEY
        ]
       
        AF.request(url,
                   method: .get,
                   headers: header).validate(statusCode: 200...500).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                                
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
