//
//  ProfileViewModel.swift
//  week18
//
//  Created by heerucan on 2022/11/03.
//

import Foundation

import RxSwift

final class ProfileViewModel {
    
    let profile = PublishSubject<Profile>()
    
    func getProfile() {
        let api = SeSACAPI.profile
        APIService.shared.requestSeSAC(type: Profile.self,
                                       url: api.url,
                                       method: .get,
                                       headers: api.headers) { [weak self] response in
            
            guard let self = self else { return }
            switch response {
            case .success(let data):
                self.profile.onNext(data)
                
            case .failure(let error):
                self.profile.onError(error)
            }
        }
    }
}
