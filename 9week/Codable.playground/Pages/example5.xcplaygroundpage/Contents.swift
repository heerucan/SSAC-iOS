//: [Previous](@previous)

import Foundation

// 서버 응답값을 좀 변경해서 모델로 넣고 싶은 경우
let json = """
{
"quote_content": "Count your age by friends, not years. Count your life by smiles, not tears.",
"author_name": null,
"likeCount": 1234
}
"""

// 만약 프로퍼티명을 좀 더 구체적으로 쓰게 된다면?
struct Quote: Decodable {
    let comment: String
    let author: String
    let like: Int
    let isInfluencer: Bool // like가 10,000개 이상인 경우
    
    enum CodingKeys: String, CodingKey { // 내부적으로 선언되어 있는 열거형
        case comment = "quote_content"
        case author = "author_name"
        case like = "likeCount"
        case isInfluencer = "isInfluencer"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        comment = try container.decode(String.self, forKey: .comment)
        author = try container.decodeIfPresent(String.self, forKey: .author) ?? "작자미상"
        like = try container.decode(Int.self, forKey: .like)
        isInfluencer = (10000...).contains(like) ? true : false // like가 10,000개 이상인 경우
    }
}


// String -> Data
guard let result = json.data(using: .utf8) else { fatalError("ERROR") }
print(result) // 114bytes


// Data -> Quote
do {
    // Decodable Type을 메타타입을 통해 명시해주고, from 누구로부터? : result로부터!
    let value = try JSONDecoder().decode(Quote.self, from: result)
    print(value)
} catch {
    print(error)
}
