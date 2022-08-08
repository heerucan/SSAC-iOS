//
//  Constant.swift
//  6weekProject
//
//  Created by heerucan on 2022/08/08.
//

import Foundation

enum Endpoint {
    case blog
    case cafe
    
    var requestURL: String {
        switch self {
        case .blog:
            return URL.makeURL("blog?query=")
        case .cafe:
            return URL.makeURL("cafe?query=")
        }
    }
}
