//
//  DiffableViewModel.swift
//  1617week
//
//  Created by heerucan on 2022/10/20.
//

import Foundation

final class DiffableViewModel {
    
    var photoList: CObservable<SearchPhoto> = CObservable(SearchPhoto(total: 0, totalPages: 0, results: []))
    
    // 검색 버튼 누르면 뷰모델한테 데이터 요청 메서드 실행해달라고 함
    // 그러면 뷰모델은 서버통신을 에피클래스한테 서치해달라고 요청
    // 에피 서비스가 다 수행하고 난 다음에 최종결과를 뷰모델에게 콜백던져줌
    // 전달 받은 데이터를 컬렉션뷰에게 던져줌
    func requestSearchPhoto(query: String) {
        APIService.shared.searchPhoto(query: query) { (photo, statusCode, error) in
            guard let photo = photo else { return }
            self.photoList.value = photo
        }
    }
}
