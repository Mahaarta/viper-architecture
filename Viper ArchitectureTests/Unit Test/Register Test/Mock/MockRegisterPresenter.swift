//
//  MockRegisterPresenter.swift
//  Viper ArchitectureTests
//
//  Created by Minata on 04/01/2024.
//

import XCTest
import RxSwift
import RxCocoa
@testable import Viper_Architecture

final class MockRegisterPresenter: RegisterInteractorToPresenterProtocol {
    
    var registerProcessSuccess: Bool?
    var registerProcessError: Error?
    
    func registerSuccess() {
        registerProcessSuccess = true
    }
    
    func registerFailed(error: Error) {
        registerProcessError = error
    }
    
}
