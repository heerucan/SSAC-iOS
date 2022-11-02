//
//  APIService.swift
//  week18
//
//  Created by heerucan on 2022/11/02.
//

import Foundation

import Alamofire

final class APIService {
    static let shared = APIService()
    private init() { }
    
    // MARK: - POST 회원가입
    
    func signup(userName: String, email: String, password: String) {
        
        let signupAPI = SeSACAPI.signup(userName: userName, email: email, password: password)
        
        AF.request(signupAPI.url,
                   method: .post,
                   parameters: signupAPI.parameters,
                   headers: signupAPI.headers)
            .responseString { response in
            switch response.result {
            case .success(let value):
                print("회원가입", value)
            case .failure(let error):
                print("회원가입", error.localizedDescription)
            }
        }
    }
    
    // MARK: - POST 로그인
    
    func login(email: String, password: String) {
        
        let loginAPI = SeSACAPI.login(email: email, password: password)

        AF.request(loginAPI.url,
                   method: .post,
                   parameters: loginAPI.parameters,
                   headers: loginAPI.headers)
            .responseDecodable(of: Login.self) { response in
                switch response.result {
                case .success(let data):
                    print(data.token)
                    UserDefaults.standard.set(data.token, forKey: "token")
                case .failure(let error):
                    print("로그인", error.localizedDescription)
                }
            }
    }
    
    // MARK: - GET 내 프로필 보기
    
    func profile() {
        
        let profileAPI = SeSACAPI.profile
        
        AF.request(profileAPI.url,
                   method: .get,
                   headers: profileAPI.headers)
            .responseDecodable(of: Profile.self) { response in
                switch response.result {
                case .success(let data):
                    print("프로필", data)
                case .failure(let error):
                    print("프로필", error.localizedDescription)
                }
            }
    }
}
