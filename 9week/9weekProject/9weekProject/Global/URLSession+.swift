//
//  URLSession+.swift
//  9weekProject
//
//  Created by heerucan on 2022/08/30.
//

import Foundation

extension URLSession {
    
    typealias completionHandler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func customDataTask(_ endpoint: URLRequest,
                        completionHandler: @escaping completionHandler) -> URLSessionDataTask {
        
        let task = dataTask(with: endpoint, completionHandler: completionHandler)
        task.resume()
        return task
        
    }
        
    // T에는 string, int 이런 것들이 들어가는 게 아니라 Codable을 채택한 아이들만 들어갈 수 있음
    static func request<T: Codable>(_ session: URLSession = .shared,
                                    endpoint: URLRequest,
                                    completion: @escaping (T?, APIError?) -> Void) {
        
        session.customDataTask(endpoint) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Failed Request")
                    completion(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    print("No Data Returned")
                    completion(nil, .noData)
                    return
                }

                guard let response = response as? HTTPURLResponse else {
                    print("Unable Response")
                    completion(nil, .invalidResponse)
                    return
                }

                guard response.statusCode == 200 else {
                    print("Failed Response")
                    completion(nil, .failedRequest)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    print(result)
                    completion(result, nil)
                } catch {
                    print(error)
                    completion(nil, .invalidData)
                }
            }
        }
    }
}
