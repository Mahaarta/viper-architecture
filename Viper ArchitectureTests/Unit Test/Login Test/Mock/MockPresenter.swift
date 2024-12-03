//
//  MockPresenter.swift
//  Viper ArchitectureTests
//
//  Created by Minata on 27/12/2023.
//

import XCTest
import RxSwift
import RxCocoa
@testable import Viper_Architecture

public class MockPresenter: LoginInteractorToPresenterProtocol {
    
    var loginSuccess: Bool?
    var loginError: Error?
    
    public func loginSuccess(loginEntity: LoginEntity?) {
        loginSuccess = true
    }
    
    public func loginFailed(error: Error) {
        loginError = error
    }
    
}

