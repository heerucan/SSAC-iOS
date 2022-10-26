//
//  NewsViewModel.swift
//  1617week
//
//  Created by heerucan on 2022/10/20.
//

import Foundation

import RxSwift
import RxCocoa

final class NewsViewModel {
    
    // MARK: - 텍스트필드에 숫자 부분 관련 코드
    // "3000"인 이유는 외부 매개변수가 생략된 상태라서 string 초기화임
    // var pageNumber: CObservable<String> = CObservable("3000")
    
//    var pageNumber = BehaviorSubject<String>(value: "3,000")
    var pageNumber = BehaviorRelay(value: "3,000")
    
    func changePageNumberFormat(text: String) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let text = text.replacingOccurrences(of: ",", with: "") // ,가 들어오면 없는 문자로 대체
        guard let number = Int(text) else { return }
        let result = numberFormatter.string(for: number)!
//        pageNumber.value = result
//        pageNumber.onNext(result)
        pageNumber.accept(result)
    }
    
    // MARK: - News 관련 코드 부분
    
//    var sampleNews: CObservable<[News.NewsItem]> = CObservable(News.items)
//    var sampleNews = BehaviorSubject(value: News.items)
    var sampleNews = BehaviorRelay(value: News.items)
    
    func resetSample() {
//        sampleNews.value = []
//        sampleNews.onNext([])
        sampleNews.accept([])
    }
    
    func loadSample() {
//        sampleNews.value = News.items
//        sampleNews.onNext(News.items)
        sampleNews.accept(News.items)
    }
}
