//
//  APIError.swift
//  week18
//
//  Created by heerucan on 2022/11/03.
//

import Foundation

@frozen
enum APIError: Int, Error {
    case badRequest = 400
    case serverError = 500
    case invalidAuthorization = 401
    case takenEmail = 406
    case emptyParameters = 501
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badRequest:
            return "잘못된 요청입니다."
        case .serverError:
            return "서버에러입니다."
        case .invalidAuthorization:
            return "토큰 만료입니다. 다시 로그인하세요"
        case .takenEmail:
            return "이미 가입된 회원입니다. 로그인 해주세요."
        case .emptyParameters:
            return "필요한 자원이 없습니다."
        }
    }
}
