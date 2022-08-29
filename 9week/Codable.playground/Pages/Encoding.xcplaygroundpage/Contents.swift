//: [Previous](@previous)

import Foundation

struct User: Encodable {
    let name: String
    let signDate: Date
    let age: Int
}

let users: [User] = [
    User(name: "루희", signDate: Date(), age: 25),
    User(name: "소연", signDate: Date(timeInterval: -86400, since: Date()), age: 24),
    User(name: "태현", signDate: Date(timeIntervalSinceNow: 86400*2), age: 26)
]

print(users)

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted
//encoder.dateEncodingStrategy = .iso8601

let format = DateFormatter()
format.locale = Locale(identifier: "ko-KR")
format.dateFormat = "MM월 dd일 EEEE"

encoder.dateEncodingStrategy = .formatted(format)


do {
    let result = try encoder.encode(users) // User -> Data
    print(result)
    
    // Data -> String
    guard let jsonString = String(data: result, encoding: .utf8) else {
        fatalError("ERROR")
    }
    
    print(jsonString)
    
} catch {
    print(error)
}

