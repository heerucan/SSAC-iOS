//
//  TMDBAPIManager.swift
//  6weekProject
//
//  Created by heerucan on 2022/08/10.
//

import Foundation

import Alamofire
import SwiftyJSON

struct TMDBAPIManager {
    
    static let shared = TMDBAPIManager()
    
    private init() { }
    
    typealias completionHandler = ([String]) -> Void
        
    let tvList = [
        ("환혼", 135157),
        ("이상한 변호사 우영우", 197067),
        ("인사이더", 135655),
        ("미스터 션사인", 75820),
        ("스카이 캐슬", 84327),
        ("사랑의 불시착", 94796),
        ("이태원 클라스", 96162),
        ("호텔 델루나", 90447)
    ]
        
    let imageURL = "https://image.tmdb.org/t/p/w500"
   
    // MARK: - GET TVList
    
    func callRequest(query: Int, completionHandler: @escaping completionHandler) {
                
        let seasonURL = "https://api.themoviedb.org/3/tv/\(query)/season/1?api_key=\(APIKey.TMDB_KEY)&language=ko-KR"
        
        AF.request(seasonURL, method: .get).validate(statusCode: 200...500).responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let path = json["episodes"].arrayValue.map
                { imageURL + $0["still_path"].stringValue }.filter { $0 != imageURL }
                
                completionHandler(path)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - GET Episode Image
    
    func requestImage(completionHandler: @escaping ([[String]]) -> ()) {
        
        var posterList: [[String]] = []
        
        TMDBAPIManager.shared.callRequest(query: tvList[0].1) { value in
            posterList.append(value)

            TMDBAPIManager.shared.callRequest(query: self.tvList[1].1) { value in
                posterList.append(value)

                TMDBAPIManager.shared.callRequest(query: self.tvList[2].1) { value in
                    posterList.append(value)
                   
                    TMDBAPIManager.shared.callRequest(query: self.tvList[3].1) { value in
                        posterList.append(value)
                     
                        TMDBAPIManager.shared.callRequest(query: self.tvList[4].1) { value in
                            posterList.append(value)
                           
                            TMDBAPIManager.shared.callRequest(query: self.tvList[5].1) { value in
                                posterList.append(value)
                                
                                TMDBAPIManager.shared.callRequest(query: self.tvList[6].1) { value in
                                    posterList.append(value)
                                    
                                    TMDBAPIManager.shared.callRequest(query: self.tvList[7].1) { value in
                                        posterList.append(value)
                                        completionHandler(posterList)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func requestEpisodeImage() {
        let id = tvList[7].1
        
        // 이렇게 해줄 경우에 생길 문제?
        // 1. 순서가 보장이 안된다. 2. 언제 끝날지 모름 3. Limit이 생길 것
        for item in tvList {
            TMDBAPIManager.shared.callRequest(query: item.1) { path in
                dump(path)
            }
        }
        
        TMDBAPIManager.shared.callRequest(query: id) { path in
            dump(path)
            
            TMDBAPIManager.shared.callRequest(query: tvList[5].1) { path in
                dump(path)
            }
        }
        
    }
}
