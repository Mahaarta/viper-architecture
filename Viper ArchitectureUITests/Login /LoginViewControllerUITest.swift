//
//  LoginViewControllerUITest.swift
//  Viper ArchitectureUITests
//
//  Created by Minata on 08/01/2024.
//

import XCTest
import RxTest
import RxCocoa
@testable import Viper_Architecture

final class LoginViewControllerUITest: XCTestCase {

    let app = XCUIApplication()
    var scheduler: TestScheduler!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        app.launch()
        scheduler = TestScheduler(initialClock: 0)
    }

    func testLoginForm() {
        let usernameTextField = app.textFields["usernameTextFieldIdentifier"]
        let passwordTextField = app.secureTextFields["passwordTextFieldIdentifier"]
        let loginButton = app.buttons["loginButtonIdentifier"]
        
        XCTAssertTrue(usernameTextField.isHittable)
        XCTAssertTrue(passwordTextField.isHittable)
        
        usernameTextField.tap()
        usernameTextField.typeText("dummy username")

        passwordTextField.tap()
        passwordTextField.typeText("dummy password")
        XCTAssertTrue(loginButton.waitForExistence(timeout: 20))
        
        loginButton.tap()
        
        /// Assert
        XCTAssertTrue(loginButton.isHittable)
        XCTAssertTrue(usernameTextField.exists)
        XCTAssertTrue(passwordTextField.exists)
        XCTAssertTrue(loginButton.exists)
    }
    
    func testNavigateToRegisterInDontHaveAccount() {
        let signUpLink = app.links.element(boundBy: 0)
        XCTAssertTrue(signUpLink.waitForExistence(timeout: 20), "Signup link not exists")
        XCTAssertTrue(signUpLink.exists)
        XCTAssertTrue(signUpLink.isHittable)
        
        signUpLink.tap()
        
        let nameTextField = app.buttons["registerButtonIdentifier"]
        XCTAssertTrue(nameTextField.waitForExistence(timeout: 10), "Navigation to RegisterViewController failed")
        XCTAssertTrue(nameTextField.exists)
    }
    
}
