//
//  NetworkManagerTest.swift
//  Viper ArchitectureTests
//
//  Created by Minata on 22/12/2023.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
import Alamofire
@testable import Viper_Architecture

final class NetworkManagerTest: XCTestCase {

    var mockManager: MockNetworkManager!
    let headers: HTTPHeaders = [
        "Accept": "application/json",
        "Content-Type": "application/json"
    ]
    
    override func setUp() {
        mockManager = MockNetworkManager()
    }

    override func tearDown() {
        mockManager = nil
        super.tearDown()
    }
    
    /// Test `NetworkManager - Success`
    func testNetworkManagerSuccess() {
        mockManager.shouldSucceed = true
        
        let observable: Observable<MockResponse> = mockManager.excuteQuery(
            url: URL(string: "https://example.com")!,
            method: .get,
            parameters: nil
        )
        
        let testScheduler = TestScheduler(initialClock: 0)
        let observer = testScheduler.createObserver(MockResponse.self)
        _ = observable.bind(to: observer)
        
        // Assert the expected values or errors using observer events
        XCTAssertEqual(observer.events, [
            Recorded.next(0, MockResponse(message: "Mocked success!")),
            Recorded.completed(0)
        ])
    }
    
    /// Test `NetworkManager - Failed`
    func testNetworkManagerFailed() {
        mockManager.shouldSucceed = false
        
        let observable: Observable<MockResponse> = mockManager.excuteQuery(
            url: URL(string: "https://example.com")!,
            method: .get,
            parameters: nil
        )
        
        let testScheduler = TestScheduler(initialClock: 0)
        let observer = testScheduler.createObserver(MockResponse.self)
        _ = observable.bind(to: observer)
        
        /// Assert the expected values or errors using observer events
        XCTAssertEqual(observer.events, [
            Recorded.error(0, NSError(domain: "MockErrorDomain", code: 43, userInfo: nil))
        ])
    }
    
    
    /// Test `Network With Encoding Success`
    func testNetworkManagerWithEncodingSuccess() {
        mockManager.shouldSucceed = true
        
        let observable: Observable<MockResponse> = mockManager.excuteQueryWithEncoding(
            url: URL(string: "https://example.com")!,
            method: .post,
            encoding: JSONEncoding.default, 
            parameters: nil,
            additionalHeaders: headers
        )
        
        let testScheduler = TestScheduler(initialClock: 0)
        let observer = testScheduler.createObserver(MockResponse.self)
        _ = observable.bind(to: observer)
        
        // Assert the expected values or errors using observer events
        XCTAssertEqual(observer.events, [
            Recorded.next(0, MockResponse(message: "Mocked success!")),
            Recorded.completed(0)
        ])
    }
    
    /// Test `Network With Encoding Failed`
    func testNetworkManagerWithEncodingFailed() {
        mockManager.shouldSucceed = false
        
        let observable: Observable<MockResponse> = mockManager.excuteQueryWithEncoding(
            url: URL(string: "https://example.com")!,
            method: .post,
            encoding: JSONEncoding.default,
            parameters: nil,
            additionalHeaders: headers
        )
        
        let testScheduler = TestScheduler(initialClock: 0)
        let observer = testScheduler.createObserver(MockResponse.self)
        _ = observable.bind(to: observer)
        
        // Assert the expected values or errors using observer events
        XCTAssertEqual(observer.events, [
            Recorded.error(0, NSError(domain: "MockErrorDomain", code: 43, userInfo: nil))
        ])
    }
    
    /// Test `Network Decode Failed`
    func testDecodeFailure() {
        mockManager.shouldSucceed = false
        
        let url = URL(string: "https://example.com")!
        let method: HTTPMethod = .get
        let parameters: Parameters? = nil
        let observable: Observable<MockResponse> = mockManager.excuteQuery(url: url, method: method, parameters: parameters)
        let expectation = self.expectation(description: "Decode failure")
        let mockError = NSError(domain: "MockErrorDomain", code: 43, userInfo: nil)
        
        _ = observable.subscribe(
            onError: { error in
                XCTAssertEqual(error as NSError, mockError)
                expectation.fulfill()
            },
            onCompleted: {
                XCTFail("Observable should not complete successfully")
            }
        ).disposed(by: DisposeBag())
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
}
