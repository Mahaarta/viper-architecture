//
//  LoginPresenterTest.swift
//  Viper ArchitectureTests
//
//  Created by Minata on 27/12/2023.
//

import XCTest
import RxSwift
import RxCocoa
@testable import Viper_Architecture

final class LoginPresenterTest: XCTestCase {
    
    /// Configure `Login Process Success`
    func testLoginProcessSuccess() {
        let mockView = MockView()
        let mockRouter = MockRouter()
        let mockInteractor = MockInteractor()
        let presenter = LoginPresenter(view: mockView, interactor: mockInteractor, router: mockRouter)
        
        let mockLoginEntity = LoginEntity(token: "mock_token")
        mockInteractor.result = Observable.just(mockLoginEntity)
        presenter.loginProcess(username: "testuser", password: "testpassword")
        
        XCTAssertTrue(mockInteractor.loginProcessCalled)
        XCTAssertEqual(mockView.loginEntity.token, mockLoginEntity.token)
    }
    
    /// Configure `Login Process Failure`
    func testLoginProcessFailure() {
        let mockView = MockView()
        let mockRouter = MockRouter()
        let mockInteractor = MockInteractor()
        let presenter = LoginPresenter(view: mockView, interactor: mockInteractor, router: mockRouter)
        
        let mockError = NSError(domain: "MockErrorDomain", code: 42, userInfo: nil)
        mockInteractor.result = Observable.error(mockError)
        presenter.loginProcess(username: "testuser", password: "testpassword")
        
        XCTAssertTrue(mockInteractor.loginProcessCalled)
        XCTAssertEqual(mockView.error, mockError)
    }
    
    /// Configure `Navigate to Register`
    func testNavigateToRegister() {
        let mockView = MockView()
        let interactor = LoginInteractor()
        let mockRouter = MockRouter()
        let presenter = LoginPresenter(view: mockView, interactor: interactor, router: mockRouter)
        
        presenter.navigateToRegister()
        
        XCTAssertTrue(mockRouter.navigateToRegisterCalled)
    }

    /// Configure `Navigate to Dashboard`
    func testNavigateToDashboard() {
        let mockView = MockView()
        let interactor = LoginInteractor()
        let mockRouter = MockRouter()
        let presenter = LoginPresenter(view: mockView, interactor: interactor, router: mockRouter)
        
        presenter.navigateToDashboard()
        
        XCTAssertTrue(mockRouter.navigateToDashboardCalled)
    }
    
}
