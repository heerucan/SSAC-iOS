//
//  APIError.swift
//  9weekProject
//
//  Created by heerucan on 2022/08/30.
//

import Foundation

enum APIError: Error {
    case invalidResponse
    case noData
    case failedRequest
    case invalidData
}
