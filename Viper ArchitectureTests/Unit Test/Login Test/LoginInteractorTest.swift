//
//  LoginInteractorTest.swift
//  Viper ArchitectureTests
//
//  Created by Minata on 27/12/2023.
//

import XCTest
import RxSwift
import RxCocoa
@testable import Viper_Architecture

class LoginInteractorTest: XCTestCase {
    
    func testLoginProcessSuccess() {
        let mockPresenter = MockPresenter()
        let interactor = LoginInteractor()
        
        interactor.presenter = mockPresenter
        interactor.loginSuccess = true
            
        let username = "mor_2314"
        let password = "83r5^_"

        interactor.loginProcess(username: username, password: password)
            .subscribe()
            .disposed(by: DisposeBag())
    }
    
    func testLoginProcessFailure() {
        let mockPresenter = MockPresenter()
        let interactor = LoginInteractor()
        let mockError = NSError(domain: "MockErrorDomain", code: 42, userInfo: nil)
        interactor.presenter = mockPresenter
        interactor.loginSuccess = false
        
        let username = "invalidUsername"
        let password = "invalidPassword"

        interactor.loginProcess(username: username, password: password)
            .subscribe(
                onError: { errorResult in
                    XCTAssertEqual(mockError, errorResult as NSError)
                }
            )
            .disposed(by: DisposeBag())
    }
    
}
