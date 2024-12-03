//
//  NewsListInteractorTest.swift
//  Viper ArchitectureTests
//
//  Created by Minata on 03/01/2024.
//

import XCTest
import RxSwift
import RxCocoa
@testable import Viper_Architecture

final class NewsListInteractorTest: XCTestCase {

    func testFetchNewsList() {
        let mockPresenter = MockNewsListPresenter()
        let interactor = NewsListInteractor()
        let source = "tech"
        
        interactor.fetchNewsList(source: source)
            .subscribe()
            .disposed(by: DisposeBag())
    }
    
}
