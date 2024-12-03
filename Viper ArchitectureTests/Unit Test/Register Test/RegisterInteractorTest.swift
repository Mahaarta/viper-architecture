//
//  RegisterInteractorTest.swift
//  Viper ArchitectureTests
//
//  Created by Minata on 04/01/2024.
//

import XCTest
import RxSwift
import RxCocoa
@testable import Viper_Architecture

final class RegisterInteractorTest: XCTestCase {
    
    func testRegisterSuccess() {
        let mockPresenter = MockRegisterPresenter()
        let interactor = RegisterInteractor()
        let mockName = "Mock Name"
        let mockEmail = "mockEmail@mail.com"
        let mockPassword = "mackpassword"
        let mockAvatar = "https://mock-avatar.png"
        
        interactor.presenter = mockPresenter
        interactor.RegisterSuccess = true
        interactor.registerProcess(name: mockName, email: mockEmail, password: mockPassword, avatar: mockAvatar)
            .subscribe()
            .disposed(by: DisposeBag())
    }
    
    func testRegisterFailed() {
        let mockPresenter = MockRegisterPresenter()
        let interactor = RegisterInteractor()
        let mockName = "Mock Name"
        let mockEmail = "mockEmail@mail.com"
        let mockPassword = "mackpassword"
        let mockAvatar = "https://mock-avatar.png"
        let mockError = NSError(domain: "MockErrorDomain", code: 42, userInfo: nil)
        
        interactor.presenter = mockPresenter
        interactor.RegisterSuccess = false
        interactor.registerProcess(name: mockName, email: mockEmail, password: mockPassword, avatar: mockAvatar)
        .subscribe(
            onError: { errorResult in
                XCTAssertEqual(mockError, errorResult as NSError)
            }
        )
        .disposed(by: DisposeBag())
    }

}
