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
    
    var url: String {
        switch self {
        case .movie: return URL.makeURL("trending/movie/day")
        case .genre: return URL.makeURL("genre/movie/list")
        case .cast, .web: return URL.makeURL("movie/")
        }
    }
    
    static let imageURL = "https://image.tmdb.org/t/p/w500"
    static let enUS = "&language=en-US"
}
