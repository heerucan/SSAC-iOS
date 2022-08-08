//
//  String+.swift
//  TMDB
//
//  Created by heerucan on 2022/08/08.
//

import Foundation

extension String {
    func changeDateFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let currentDate = formatter.date(from: self)
        let stringDate = formatter.string(from: currentDate!)
        return stringDate
    }
}
