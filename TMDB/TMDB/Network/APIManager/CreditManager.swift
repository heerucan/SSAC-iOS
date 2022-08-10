//
//  CreditManager.swift
//  TMDB
//
//  Created by heerucan on 2022/08/07.
//

import Foundation

import Alamofire
import SwiftyJSON

struct CreditManager {
    
    static let shared = CreditManager()
    
    typealias completionHandler = ([Cast], [Crew]) -> Void
    
    private init() { }
        
    // MARK: - GET : CREDIT
    
    func requestCredit(movieID: Int, completionHandler: @escaping completionHandler) {
        let url = EndPoint.cast.url +
        "\(movieID)/credits\(APIKey.movieKey)" + EndPoint.enUS

        AF.request(url, method: .get).validate(statusCode: 200...500).responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                 
                let castList = json["cast"].arrayValue.map {
                    Cast(name: $0["name"].stringValue,
                         character: $0["character"].stringValue,
                         image: URL(string: EndPoint.imageURL + $0["profile_path"].stringValue)!)
                }

                let crewList = json["crew"].arrayValue.map {
                    Crew(name: $0["name"].stringValue,
                         department: $0["department"].stringValue,
                         job: $0["job"].stringValue,
                         image: URL(string: EndPoint.imageURL + $0["profile_path"].stringValue)!)
                }
                completionHandler(castList, crewList)
                                
            case .failure(let error):
                print(error)
            }
        }
    }
}
