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
    
    typealias completionHandler = ([Movie]) -> Void
        
    // MARK: - GET : MOVIE List
    
    func requestMovie(completionHandler: @escaping completionHandler) {
        
        let url = EndPoint.movieURL + "?api_key=\(APIKey.movieKey)"
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseData(queue: .global()) { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let movieList = json["results"].arrayValue.map {
                    Movie(title: $0["title"].stringValue,
                          backImage: URL(string: EndPoint.imageURL + $0["backdrop_path"].stringValue)!,
                          date: $0["release_date"].stringValue,
                          genre: $0["genre_ids"].intValue,
                          image: URL(string: EndPoint.imageURL + $0["poster_path"].stringValue)!,
                          overview: $0["overview"].stringValue,
                          rate: $0["vote_average"].doubleValue,
                          id: $0["id"].intValue)
                }

                completionHandler(movieList)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
