//
//  News.swift
//  1617week
//
//  Created by heerucan on 2022/10/20.
//

import Foundation

struct News {
    
    struct NewsItem: Hashable {
        let title: String
        let date: Date
        let body: String
        let identifier = UUID()

        init(title: String, date: DateComponents, body: String) {
            self.title = title
            self.date = DateComponents(calendar: Calendar.current,
                                       year: date.year,
                                       month: date.month,
                                       day: date.day).date!
            self.body = body
        }
    }
    
    static var items: [NewsItem] = {
       return itemsInternal()
    }()
}

extension News {
    private static func itemsInternal() -> [NewsItem] {
        return [ NewsItem(title: "루희가 취업했때 어머어머어머 연봉 7천마넌..",
                              date: DateComponents(year: 2024, month: 3, day: 14), body: """
                    후리방구가 오늘 취업을 했따는 속보가 들어왔숩니다. 연봉은 7천마넌이구요
                    복지가 엄청나게 좋다.. 최고방구다... 워라벨도 최고다.. 무야호,, 
                    """),
                 NewsItem(title: "Apply for a Conference19 Scholarship",
                              date: DateComponents(year: 2019, month: 3, day: 14), body: """
                    Conference Scholarships reward talented studens and STEM orgination members with the opportunity
                    to attend this year's conference. Apply by Sunday, March 24, 2019 at 5:00PM PDT
                    """),
                 NewsItem(title: "Conference18 Video Subtitles Now in More Languages",
                              date: DateComponents(year: 2019, month: 8, day: 8), body: """
                    All of this year's session videos are now available with Japanese and Simplified Chinese subtitles.
                    Watch in the Videos tab or on the Apple Developer website.
                    """),
                 NewsItem(title: "Lunchtime Inspiration",
                              date: DateComponents(year: 2019, month: 6, day: 8), body: """
                    All of this year's session videos are now available with Japanese and Simplified Chinease subtitles.
                    Watch in the Videos tab or on the Apple Developer website.
                    """),
                 NewsItem(title: "Close Your Rings Challenge",
                              date: DateComponents(year: 2019, month: 6, day: 8), body: """
                    Congratulations to all Close Your Rings Challenge participants for staying active
                    throughout the week! Everyone who participated in the challenge can pick up a
                    special reward pin outside on the Plaza until 5:00 p.m.
                    """)
        ]
    }
}
