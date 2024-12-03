//
//  MockInteractor.swift
//  Viper ArchitectureTests
//
//  Created by Minata on 27/12/2023.
//

import XCTest
import RxSwift
import RxCocoa
@testable import Viper_Architecture

class MockInteractor: LoginPresenterToInteractorProtocol {
    var presenter: LoginInteractorToPresenterProtocol?
    var loginSuccess: Bool?
    var loginProcessCalled = false
    var result: Observable<LoginEntity?> = Observable.empty()
    
    func loginProcess(username: String, password: String) -> Observable<LoginEntity?> {
        loginProcessCalled = true
        return result
    }
}
