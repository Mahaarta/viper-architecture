//
//  MockView.swift
//  Viper ArchitectureTests
//
//  Created by Minata on 27/12/2023.
//

import UIKit
import XCTest
import RxSwift
import RxCocoa
@testable import Viper_Architecture

class MockView: UIViewController, LoginPresenterToViewProtocol {
    var loginSuccess = PublishRelay<Void>()
    var showError = PublishRelay<Void>()
    var navigateToRegister = PublishRelay<Void>()
    var navigateToDashboard = PublishRelay<Void>()
    var mockNavigationController: UINavigationController?
    var loginEntity: LoginEntity = LoginEntity(token: "mock_token")
    var error: NSError = NSError(domain: "MockErrorDomain", code: 42, userInfo: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
