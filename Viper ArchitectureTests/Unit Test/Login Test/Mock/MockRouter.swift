//
//  MockRouter.swift
//  Viper ArchitectureTests
//
//  Created by Minata on 27/12/2023.
//

import UIKit
import XCTest
@testable import Viper_Architecture

class MockRouter: LoginRoute {
    
    var navigateToRegisterCalled = false
    var navigateToDashboardCalled = false
    
    override func navigateToRegister(from view: LoginPresenterToViewProtocol?) {
        super.navigateToRegister(from: view)
        navigateToRegisterCalled = true
    }
    
    override func navigateToDashboard(from view: LoginPresenterToViewProtocol?) {
        super.navigateToDashboard(from: view)
        let lastView = RegisterRoute.createModule()
        navigateToDashboardCalled = true
        removeAllViewControllerExceptLast(view, lastView: lastView)
    }
    
}
