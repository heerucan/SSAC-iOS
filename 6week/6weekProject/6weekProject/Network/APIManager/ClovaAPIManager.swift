//
//  ClovaAPIManager.swift
//  6weekProject
//
//  Created by heerucan on 2022/08/12.
//

import Foundation

import Alamofire
import SwiftyJSON
import UIKit

struct ClovaAPIManager {
    
    static let shared = ClovaAPIManager()
    private init() { }
    
    typealias completionHandler = (String) -> Void
    
    // MARK: - POST : POST IMAGE
    
    func postImage(image: UIImage, completionHandler: @escaping completionHandler) {
        let url = Endpoint.clova.requestURL
        
        /* 어떤 파일의 종류가 서버에게 전달이 되는지 명시하는 게 필요하고,
         이걸 Content-Type이라고 한다.
         이 친구는 헤더에 보통 추가해서 작업한다.*/
        let header: HTTPHeaders = ["Content-Type": "multipart/form-data",
                                   "X-Naver-Client-Id": APIKey.NAVER_ID,
                                   "X-Naver-Client-Secret": APIKey.NAVER_KEY]
        
        // UIImage를 텍스트 형태 (바이너리 타입)로 변환해서 전달
        guard let imageData = image.pngData() else { return }

        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image")
        }, to: url, headers: header)
            .validate(statusCode: 200..<400).responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let result = json["faces"].arrayValue.map { $0["celebrity"]["value"].stringValue }[0]
                completionHandler(result)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
