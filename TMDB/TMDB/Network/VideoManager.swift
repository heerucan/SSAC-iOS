//
//  VideoManager.swift
//  TMDB
//
//  Created by heerucan on 2022/08/07.
//

import Foundation

import Alamofire
import SwiftyJSON

struct VideoManager {
    static let shared = VideoManager()
    
    typealias completionHandler = (String) -> Void
    
    private init() { }
    
    func requestVideo(movieID: Int, completionHandler: @escaping completionHandler) {
        
        let url = EndPoint.youtubeURL + "\(movieID)/videos?api_key=\(APIKey.movieKey)&language=en-US"

        AF.request(url, method: .get).validate(statusCode: 200...500).responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)                
                let link = json["results"][0]["key"].stringValue
                
                completionHandler(link)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
