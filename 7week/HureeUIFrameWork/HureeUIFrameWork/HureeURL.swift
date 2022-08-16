//
//  HureeURL.swift
//  HureeUIFrameWork
//
//  Created by heerucan on 2022/08/16.
//

import Foundation

extension URL {    
    public static func makeURL(_ baseURL: String, endpoint: String) -> String {
        return baseURL + endpoint
    }
}
