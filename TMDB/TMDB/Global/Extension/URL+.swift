//
//  URL+.swift
//  TMDB
//
//  Created by heerucan on 2022/08/08.
//

import Foundation

extension URL {
    static let baseURL = "https://api.themoviedb.org/3/"
    
    static func makeURL(_ endpoint: String) -> String {
        return baseURL + endpoint
    }
}
