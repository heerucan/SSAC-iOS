//
//  ImageSearchAPIManager.swift
//  NetworkBasic
//
//  Created by heerucan on 2022/08/05.
//

import Foundation

import Alamofire
import SwiftyJSON

// 클래스 싱글턴 패턴 vs 구조체 싱글턴 패턴
class ImageSearchAPIManager {
    
    static let shared = ImageSearchAPIManager()
    
    // 기존에 매개변수 타입과 반환타입으로 들어가야 할 것을 typealias로 붙여줌으로써 좀 더 이쁜 코드로 보임
    typealias completionHandler = (Int, [String]) -> Void
    
    // @escaping 클로저 : 밖에서 사용하겠다.
    func fetchImageData(query: String, startPage: Int,
                        completionHandler: @escaping completionHandler) {
        
        // 한글이 안되는 경우 : utf-8로 인코딩 하기 때문에 내부 처리가 필요함
        guard let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = EndPoint.imageSearchURL + "query=\(text)&display=30&start=\(startPage)"
        
        // Header : 메타정보
        // Body : 실질적인 데이터
        
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.NAVER_SEARCH_ID,
            "X-Naver-Client-Secret": APIKey.NAVER_SEARCH_KEY
        ]
       
        AF.request(url,
                   method: .get,
                   headers: header).validate(statusCode: 200...500).responseData { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                // 이걸 뷰컨에서 전달할게, totalCount와 list를 전달할게!
                let totalCount = json["total"].intValue
                let list = json["items"].arrayValue.map { $0["link"].stringValue }
//                for image in json["items"].arrayValue {
//                    self.imageList.append(image["link"].stringValue)
//                }
                
                completionHandler(totalCount, list)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
