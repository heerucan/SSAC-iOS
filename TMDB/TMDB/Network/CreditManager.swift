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
    
    typealias completionHandler = (Cast) -> Void
    
    // MARK: - GET : CREDIT
    
    func requestCredit(movieID: Int, completionHandler: @escaping completionHandler) {
        let url = EndPoint.castURL + "\(movieID)/credits?api_key=\(APIKey.movieKey)&language=en-US"

        AF.request(url, method: .get).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                                
                for crew in json["crew"].arrayValue {
                    let name = crew["name"].stringValue
                    let castName = crew["original_name"].stringValue
                    let character = crew["character"].stringValue
                    let image = URL(string: EndPoint.imageURL + crew["profile_path"].stringValue)
                    
                    let castList = Cast(name: name, castName: castName, character: character, image: image)
                    completionHandler(castList)
                }
                                
            case .failure(let error):
                print(error)
            }
        }
    }
}
