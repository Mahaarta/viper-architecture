//
//  MockNewsListInteractor.swift
//  Viper ArchitectureTests
//
//  Created by Minata on 28/12/2023.
//

import XCTest
import RxSwift
import RxCocoa
@testable import Viper_Architecture

class MockNewsListInteractor: NewsListPresenterToInteractorProtocol {
    
    var fetchNewsListSource: String?
    var fetchNewsCalled: Bool = false
    var newsListDatas: [NewsListEntity]?
    var onErrorBlock: ((Error) -> Void)?
    var presenter: NewsListInteractorToPresenterProtocol?
    var result: Observable<NewsResponse?> = Observable.empty()
    
    func fetchNewsList(source: String) -> Observable<NewsResponse?> {
        fetchNewsCalled = true
        fetchNewsListSource = source
        
        if let onErrorBlock = onErrorBlock {
            onErrorBlock(MockError.someError)
            return Observable.error(MockError.someError)
        }
        
        return Observable.just(NewsResponse(status: "success", results: newsListDatas))
    }
    
}
