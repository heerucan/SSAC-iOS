//
//  URL+.swift
//  6weekProject
//
//  Created by heerucan on 2022/08/08.
//

import Foundation

extension URL {
    static let baseURL = "https://dapi.kakao.com/v2/search/"
    
    static func makeURL(_ endpoint: String) -> String {
        return baseURL + endpoint
    }
}
