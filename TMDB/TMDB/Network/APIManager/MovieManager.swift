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
    typealias genreCompletionHandler = ([Genre]) -> Void
    
    private init() { }
        
    // MARK: - GET : MOVIE LIST
    
    func requestMovie(pageNumber:Int, completionHandler: @escaping completionHandler) {
        
        let url = EndPoint.movie.url + "?api_key=\(APIKey.movieKey)&page=\(pageNumber)"
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let movieList = json["results"].arrayValue.map {
                    Movie(title: $0["title"].stringValue,
                          backImage: URL(string: EndPoint.imageURL + $0["backdrop_path"].stringValue)!,
                          date: $0["release_date"].stringValue,
                          genre: $0["genre_ids"][0].intValue,
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
    
    // MARK: - GET : GENRE LIST
    
    func requestGenre(_ genreCompletionHandler: @escaping genreCompletionHandler) {
        
        let genreURL = EndPoint.genre.url + "?api_key=\(APIKey.movieKey)" + EndPoint.enUS
        
        AF.request(genreURL, method: .get).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let genreList = json["genres"].arrayValue.map {
                    Genre(id: $0["id"].intValue,
                          genre: $0["name"].stringValue)
                }
                genreCompletionHandler(genreList)
                
            case .failure(let error):
                print(error)
            }
        }
    }

}
