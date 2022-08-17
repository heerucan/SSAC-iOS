//
//  Constant.swift
//  TMDB
//
//  Created by heerucan on 2022/08/03.
//

import Foundation

enum Storyboard {
    static let main = "Main"
    static let onboard = "Onboard"
}

enum Nib {
    static let poster = "PosterView"
    static let content = "ContentCollectionViewCell"
}

enum MediaType: String {
    case all, movie, tv, person
}

enum TimeWindow: String {
    case day, week
}

enum Key: String {
    case first = "first"
    static let firstUser = UserDefaults.standard.bool(forKey: Key.first.rawValue)
}
