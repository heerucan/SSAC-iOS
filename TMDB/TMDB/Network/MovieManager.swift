//
//  MovieManager.swift
//  TMDB
//
//  Created by heerucan on 2022/08/06.
//

import Foundation

import Alamofire
import SwiftyJSON

struct MovieManager {
    
    static let shared = MovieManager()
    
    typealias completionHandler = (Movie) -> Void
        
    // MARK: - GET : MOVIE List
    
    func requestMovie(completionHandler: @escaping completionHandler) {
        
        let url = EndPoint.movieURL + "?api_key=\(APIKey.movieKey)"
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseData { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
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
}
