//
//  KakaoAPIManager.swift
//  6weekProject
//
//  Created by heerucan on 2022/08/08.
//

import Foundation

import Alamofire
import SwiftyJSON

class KakaoAPIManager {
    
    static let shared = KakaoAPIManager()
    
    private init() { }
    
    typealias completionHandler = (JSON) -> ()
    
    let header: HTTPHeaders = ["Authorization": "KakaoAK \(APIKey.KAKAO_KEY)"]
    
    func callRequest(_ type: Endpoint,
                     query: String,
                     completionHandler: @escaping completionHandler) {

        guard let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = type.requestURL + "\(text)"
        
        // Alamofire 내에 URLSession Framework에서 코드가 비동기로 바뀌게 된다.
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                completionHandler(json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
