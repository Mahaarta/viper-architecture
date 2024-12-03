//
//  NewsListViewControllerUITest.swift
//  Viper ArchitectureUITests
//
//  Created by Minata on 11/01/2024.
//

import XCTest
import RxTest
import RxSwift
import RxCocoa
@testable import Viper_Architecture

final class NewsListViewControllerUITest: XCTestCase {

    let app = XCUIApplication()
    var scheduler: TestScheduler!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        app.launch()
        scheduler = TestScheduler(initialClock: 0)
    }
    
    func testNewsListTableView() {
        let usernameTextField = app.textFields["usernameTextFieldIdentifier"]
        let passwordTextField = app.secureTextFields["passwordTextFieldIdentifier"]
        let loginButton = app.buttons["loginButtonIdentifier"]
        let tableViewIdentifier = app.tables.matching(identifier: "newsListTableViewIdentifier")
        XCTAssertTrue(usernameTextField.isHittable)
        XCTAssertTrue(passwordTextField.isHittable)
        
        usernameTextField.tap()
        usernameTextField.typeText("mor_2314")

        passwordTextField.tap()
        passwordTextField.typeText("83r5^_")
        
        loginButton.tap()
        
        /// Assert
        XCTAssertTrue(usernameTextField.exists)
        XCTAssertTrue(passwordTextField.exists)
        XCTAssertTrue(loginButton.isHittable)
        XCTAssertTrue(loginButton.exists)
    }
    
    func testAlertNewsListView() {
        let usernameTextField = app.textFields["usernameTextFieldIdentifier"]
        let passwordTextField = app.secureTextFields["passwordTextFieldIdentifier"]
        let loginButton = app.buttons["loginButtonIdentifier"]
        
        XCTAssertTrue(usernameTextField.isHittable)
        XCTAssertTrue(passwordTextField.isHittable)
        
        usernameTextField.tap()
        usernameTextField.typeText("mor_2314")

        passwordTextField.tap()
        passwordTextField.typeText("83r5^_")
        
        loginButton.tap()
        
        /// Assert
        XCTAssertTrue(usernameTextField.exists)
        XCTAssertTrue(passwordTextField.exists)
        XCTAssertTrue(loginButton.isHittable)
        XCTAssertTrue(loginButton.exists)
        
    }
    
}
