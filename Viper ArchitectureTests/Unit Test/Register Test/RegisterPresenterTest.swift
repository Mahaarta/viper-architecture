//
//  RegisterPresenterTest.swift
//  Viper ArchitectureTests
//
//  Created by Minata on 03/01/2024.
//

import XCTest
import RxTest
import RxSwift
import RxCocoa
@testable import Viper_Architecture

final class RegisterPresenterTest: XCTestCase {

    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    func testRegisterSuccess() {
        let route = RegisterRoute()
        let mockView = MockRegisterView()
        let interactor = MockRegisterInteractor()
        let presenter = RegisterPresenter(view: mockView, interactor: interactor, router: route)
        let testScheduler = scheduler
        
        let registerEntity = RegisterEntity(
            id: 0,
            name: "mock name", 
            role: "mock role", 
            email: "mockEmail@mail.com",
            avatar: "https://mock-image.png",
            password: "mock password",
            updatedAt: "2024-01-01",
            creationAt: "2024-01-01"
        )
        
        let registerSuccessRelay = PublishRelay<Void>()
        mockView.registerSuccess = registerSuccessRelay
        
        interactor.registerData = registerEntity
        interactor.result = Observable.just(registerEntity)
        
        mockView.viewDidLoad()
        presenter.registerProcess(name: "mock name", email: "mockEmail@mail.com", password: "mockPassword", avatar: "https://mock-avatar.png")
        
        registerSuccessRelay.subscribe(onNext: {
            print("registerSuccessRelay event manually triggered")
        }).disposed(by: disposeBag)
        
        registerSuccessRelay.accept(())
        testScheduler?.start()
        
        /// Assert
        XCTAssertTrue(interactor.registerProcessCalled)
        XCTAssertTrue(mockView.registerSuccessCalled)
    }
    
    func testRegisterFailed() {
        let route = RegisterRoute()
        let mockView = MockRegisterView()
        let interactor = MockRegisterInteractor()
        let presenter = RegisterPresenter(view: mockView, interactor: interactor, router: route)
        
        let mockError = NSError(domain: "MockErrorDomain", code: 42, userInfo: nil)
        interactor.result = Observable.error(mockError)
        presenter.registerProcess(name: "mock name", email: "mockEmail@mail.com", password: "mockPassword", avatar: "https://mock-avatar.png")
        
        XCTAssertTrue(interactor.registerProcessCalled)
        XCTAssertFalse(mockView.registerSuccessCalled)
    }

}
