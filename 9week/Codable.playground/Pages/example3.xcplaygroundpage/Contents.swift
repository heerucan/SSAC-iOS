//: [Previous](@previous)

import Foundation

let json = """
{
"quote_content": "Count your age by friends, not years. Count your life by smiles, not tears.",
"author_name": "John Lennon"
}
"""

// 만약 프로퍼티명을 좀 더 구체적으로 쓰게 된다면?
struct Quote: Decodable {
    let quoteContent: String
    let authorName: String
}


// String -> Data
guard let result = json.data(using: .utf8) else { fatalError("ERROR") }
print(result) // 114bytes

let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromSnakeCase

// Data -> Quote
do {
    // Decodable Type을 메타타입을 통해 명시해주고, from 누구로부터? : result로부터!
    let value = try decoder.decode(Quote.self, from: result)
    print(value)
} catch {
    print(error)
}
