//
//  EndPoint.swift
//  TMDB
//
//  Created by heerucan on 2022/08/08.
//

import Foundation

enum EndPoint {
    case movie
    case genre
    case cast
    case web
    case similar
        
    var url: String {
        switch self {
        case .movie:
            return URL.makeURL(URL.baseURL,
                               endpoint: "trending/\(MediaType.movie.rawValue)/\(TimeWindow.day.rawValue)")
        case .genre:
            return URL.makeURL(URL.baseURL,
                               endpoint: "genre/movie/list")
        case .cast, .web, .similar:
            return URL.makeURL(URL.baseURL,
                               endpoint: "movie/")
        }
    }
    
    static let imageURL = "https://image.tmdb.org/t/p/w500"
    static let enUS = "&language=en-US"
    static let youtubeURL = "https://www.youtube.com/watch?v="
}
