//
//  Profile.swift
//  week18
//
//  Created by heerucan on 2022/11/02.
//

import Foundation

// MARK: - Profile

struct Profile: Codable {
    let user: User
}

// MARK: - User

struct User: Codable {
    let photo, email, username: String

    enum CodingKeys: String, CodingKey {
        case photo, email, username
    }
}
