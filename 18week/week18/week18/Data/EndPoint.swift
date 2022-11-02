//
//  EndPoint.swift
//  week18
//
//  Created by heerucan on 2022/11/02.
//

import Foundation
import Alamofire

@frozen
enum SeSACAPI {
    case signup(userName: String, email: String, password: String)
    case login(email: String, password: String)
    case profile
}

extension SeSACAPI {
    
    var url: URL {
        switch self {
        case .signup:
            return URL(string: APIKey.baseURL + "signup")!
        case .login:
            return URL(string: APIKey.baseURL + "login")!
        case .profile:
            return URL(string: APIKey.baseURL + "me")!
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .signup, .login:
            return ["Content-Type": "application/x-www-form-urlencoded"]
        case .profile:
            return ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "token")!)"]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .signup, .login:
            return .post
        case .profile:
            return .get
        }
    }
    
    var parameters: [String: String] {
        switch self {
        case .signup(let userName, let email, let password):
            return [
                "userName": userName,
                "email": email,
                "password": password
            ]
        case .login(let email, let password):
            return [
                "email": email,
                "password": password
            ]
        default: return ["":""]
        }
    }
}
