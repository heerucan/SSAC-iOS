//
//  Person.swift
//  9weekProject
//
//  Created by heerucan on 2022/08/30.
//

import Foundation

// MARK: - Person
struct Person: Codable {
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Result: Codable {
    let adult: Bool
    let gender, id: Int
    let knownForDepartment, name: String
    let popularity: Double
    
    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name, popularity
    }
}
