import UIKit

let json = """
{
"quote": "Count your age by friends, not years. Count your life by smiles, not tears.",
"author": "John Lennon"
}
"""

// JSON을 담아주기 위해 프로토콜 채택
struct Quote: Decodable {
    let quote: String
    let author: String
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
