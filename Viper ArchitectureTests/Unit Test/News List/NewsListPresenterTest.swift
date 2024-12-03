//
//  NewsListPresenterTest.swift
//  Viper ArchitectureTests
//
//  Created by Minata on 28/12/2023.
//

import XCTest
import RxTest
import RxSwift
import RxCocoa
@testable import Viper_Architecture

final class NewsListPresenterTest: XCTestCase {

    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    func testFetchNewsSuccess() {
        let mockView = MockNewsListView()
        let router = NewsListRoute()
        let mockInteractor = MockNewsListInteractor()
        let presenter = NewsListPresenter(view: mockView, interactor: mockInteractor, router: router)
        
        let testScheduler = scheduler
        let source = "your_source"
        
        /// Create a PublishRelay to simulate the reloadData event
        let reloadDataRelay = PublishRelay<Void>()
        mockView.reloadData = reloadDataRelay
        mockView.viewDidLoad()
        
        /// Act
        presenter.updateView(source: source)
        testScheduler?.start()
        
        /// Assert
        XCTAssertTrue(mockInteractor.fetchNewsCalled)
        XCTAssertEqual(mockInteractor.fetchNewsListSource, source)
        XCTAssertTrue(mockView.reloadDataCalled)
        XCTAssertFalse(mockView.reloadDataFailedCalled)
    }
    
    func testFetchNewsFailed() {
        let mockView = MockNewsListView()
        let router = NewsListRoute()
        let mockInteractor = MockNewsListInteractor()
        let presenter = NewsListPresenter(view: mockView, interactor: mockInteractor, router: router)
        
        let testScheduler = scheduler
        let source = "your_source"
        
        /// Create a PublishRelay to simulate the reloadData event
        let showErrorRelay = PublishRelay<Void>()
        mockView.showError = showErrorRelay
        mockView.viewDidLoad()
        
        /// Manually trigger the showError event
        mockInteractor.onErrorBlock = { error in
            showErrorRelay.accept(())
        }
        
        /// Act
        presenter.updateView(source: source)
        testScheduler?.start()
        
        /// Assert
        XCTAssertTrue(mockInteractor.fetchNewsCalled)
        XCTAssertEqual(mockInteractor.fetchNewsListSource, source)
        XCTAssertTrue(mockView.reloadDataFailedCalled)
        XCTAssertFalse(mockView.reloadDataCalled)
    }
    
    func testGetNewsListCount() {
        let mockView = MockNewsListView()
        let router = NewsListRoute()
        let mockInteractor = MockNewsListInteractor()
        let presenter = NewsListPresenter(view: mockView, interactor: mockInteractor, router: router)

        /// Set up mock interactor's newsListDatas with some data
        mockInteractor.newsListDatas = [
            NewsListEntity(language: "en", title: "Title 1", description: "Description 1", image_url: "url1", content: "Content 1"),
            NewsListEntity(language: "en", title: "Title 2", description: "Description 2", image_url: "url2", content: "Content 2")
        ]

        /// Act
        let count = presenter.getNewsListCount()

        /// Assert
        XCTAssertEqual(count, mockInteractor.newsListDatas?.count)
    }
    
    func testGetNewsListAtIndex() {
        let mockView = MockNewsListView()
        let router = NewsListRoute()
        let mockInteractor = MockNewsListInteractor()
        let presenter = NewsListPresenter(view: mockView, interactor: mockInteractor, router: router)

        /// Set up mock interactor's newsListDatas with some data
        let mockData = [
            NewsListEntity(language: "en", title: "Title 1", description: "Description 1", image_url: "url1", content: "Content 1"),
            NewsListEntity(language: "en", title: "Title 2", description: "Description 2", image_url: "url2", content: "Content 2"),
            NewsListEntity(language: "en", title: "Title 3", description: "Description 3", image_url: "url3", content: "Content 3")
        ]
        mockInteractor.newsListDatas = mockData

        /// Act & Assert for each index
        for (index, expectedEntity) in mockData.enumerated() {
            print("enumerated index \(index)")
            let entity = presenter.getNewsList(at: index)
            XCTAssertEqual(entity, expectedEntity)
        }

        /// Assert for an out-of-bounds index
        let outOfBoundsEntity = presenter.getNewsList(at: mockData.count)
        XCTAssertNil(outOfBoundsEntity)
    }
    
    func testAlertError() {
        let testScheduler = scheduler
        let showErrorRelay = PublishRelay<Void>()
        let mockView = MockNewsListView()
        
        mockView.showError = showErrorRelay
        mockView.viewDidLoad()
        
        showErrorRelay.accept(())
        testScheduler?.start()
        
        XCTAssertTrue(mockView.reloadDataFailedCalled)
        XCTAssertFalse(mockView.reloadDataCalled)
    }

}
