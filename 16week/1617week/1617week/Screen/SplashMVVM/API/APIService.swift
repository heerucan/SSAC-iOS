//
//  APIService.swift
//  1617week
//
//  Created by heerucan on 2022/10/20.
//

import Foundation

import Alamofire

final class APIService {
    
    static let shared = APIService()
    private init() { }
    
    typealias completion = ((SearchPhoto?, Int?, Error?) -> Void)

    static func searchPhoto(query: String, completion: @escaping completion) {
        let url = "\(APIKey.searchURL)\(query)"
        let header: HTTPHeaders = ["Authorization": APIKey.authorization]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: SearchPhoto.self) { response in
            let statusCode = response.response?.statusCode
            
            
            switch response.result {
            case .success(let value):
                completion(value, statusCode, nil)
                print(value)
                
            case .failure(let error):
                completion(nil, statusCode, error)
                print(error)
                
            }
        }
    }
}
