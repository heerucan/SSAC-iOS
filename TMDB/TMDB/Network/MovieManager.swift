//
//  APIManager.swift
//  TMDB
//
//  Created by heerucan on 2022/08/06.
//

import Foundation

import Alamofire
import SwiftyJSON

struct APIManager {
    
    static let shared = APIManager()
    
    typealias completionHandler = (Movie) -> Void
    typealias completionH
    
    // MARK: - GET : GENRE
    
    // MARK: - GET : MOVIE List
    
    func requestMovie(completionHandler: @escaping completionHandler) {
        
        let url = EndPoint.movieURL + "?api_key=\(APIKey.movieKey)"
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseData { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for movie in json["results"].arrayValue {
                    
                    let title = movie["title"].stringValue
                    let poster = URL(string: EndPoint.imageURL + movie["poster_path"].stringValue)
                    let rate = movie["vote_average"].doubleValue
                    let overview = movie["overview"].stringValue
                    let date = movie["release_date"].stringValue
                    let genre = movie["genre_ids"][0].intValue
                    let id = movie["id"].intValue
                                                                                
                    let movieList = Movie(title: title,
                                          date: date,
                                          genre: "#Movie",
                                          image: poster,
                                          overview: overview,
                                          rate: rate,
                                          id: id)
                    
                    completionHandler(movieList)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
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
                }
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
