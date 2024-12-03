//
//  MockNewsListPresenter.swift
//  Viper ArchitectureTests
//
//  Created by Minata on 03/01/2024.
//

import XCTest
import RxSwift
import RxCocoa
@testable import Viper_Architecture

final class MockNewsListPresenter: NewsListInteractorToPresenterProtocol {
    
    var newsListFetchedSuccess: Bool?
    var newsListFetchedError: Error?
    
    func newsListFetched(newsData: NewsResponse?) {
        newsListFetchedSuccess = true
    }
    
    func newsListFetchedFailed(error: Error) {
        newsListFetchedError = error
    }
    
}
