//
//  Constant.swift
//  TMDB
//
//  Created by heerucan on 2022/08/03.
//

import Foundation

enum Storyboard {
    static let main = "Main"
}

enum EndPoint {
    static let movieURL = "https://api.themoviedb.org/3/trending/movie/day"
    static let genreURL = "https://api.themoviedb.org/3/genre/movie/list"
    static let imageURL = "https://image.tmdb.org/t/p/w500"
    static let castURL = "https://api.themoviedb.org/3/movie/"
    static let youtubeURL = "https://api.themoviedb.org/3/movie/"
    
    static let enUS = "&language=en-US"
}
