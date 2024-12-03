//
//  RegisterViewControllerUITest.swift
//  Viper ArchitectureUITests
//
//  Created by Minata on 10/01/2024.
//

import XCTest
import RxSwift
@testable import Viper_Architecture

final class RegisterViewControllerUITest: XCTestCase {

    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        app.launch()
    }
    
    func testRegisterForm() {
        let signUpLink = app.links.element(boundBy: 0)
        XCTAssertTrue(signUpLink.waitForExistence(timeout: 20), "Signup link not exists")
        XCTAssertTrue(signUpLink.exists)
        XCTAssertTrue(signUpLink.isHittable)
        
        signUpLink.tap()
        
        let nameTextField = app.buttons["registerButtonIdentifier"]
        XCTAssertTrue(nameTextField.waitForExistence(timeout: 10), "Navigation to RegisterViewController failed")
        XCTAssertTrue(nameTextField.exists)
        
        let usernameTextField = app.textFields["nameTextFieldIdentifier"]
        let emailTextField = app.textFields["emailTextFieldIdentifier"]
        let passwordTextField = app.secureTextFields["passwordTextFieldIdentifier"]
        let registerButton = app.buttons["registerButtonIdentifier"]
        
        
        /// Assert for text field
        XCTAssertTrue(usernameTextField.exists)
        XCTAssertTrue(usernameTextField.isHittable)
        
        XCTAssertTrue(emailTextField.exists)
        XCTAssertTrue(emailTextField.isHittable)
        
        XCTAssertTrue(passwordTextField.exists)
        XCTAssertTrue(passwordTextField.isHittable)
        
        XCTAssertTrue(registerButton.exists)
        XCTAssertTrue(registerButton.isHittable)
        
        usernameTextField.tap()
        usernameTextField.typeText("test username")
        
        emailTextField.tap()
        emailTextField.typeText("testemail@mail.com")
        
        passwordTextField.tap()
        passwordTextField.typeText("testPassword")
        
        registerButton.tap()
    }
    
    func testAlreadyHasAnAccountLink() {
        let signUpLink = app.links.element(boundBy: 0)
        XCTAssertTrue(signUpLink.waitForExistence(timeout: 20), "Signup link not exists")
        XCTAssertTrue(signUpLink.exists)
        XCTAssertTrue(signUpLink.isHittable)
        
        signUpLink.tap()
        
        let signInLink = app.links.element(boundBy: 0)
        XCTAssertTrue(signInLink.waitForExistence(timeout: 20), "signIn link not exists")
        XCTAssertTrue(signInLink.exists)
        XCTAssertTrue(signInLink.isHittable)
        
        signInLink.tap()
        
        let nameTextField = app.textFields["usernameTextFieldIdentifier"]
        XCTAssertTrue(nameTextField.waitForExistence(timeout: 10), "Navigation Back to LoginViewController failed")
        XCTAssertTrue(nameTextField.exists)
        
        let usernameTextField = app.textFields["usernameTextFieldIdentifier"]
        let loginButton = app.buttons["loginButtonIdentifier"]
        
        
        /// Assert for text field
        XCTAssertTrue(usernameTextField.exists)
        XCTAssertTrue(usernameTextField.isHittable)
        
        XCTAssertTrue(loginButton.exists)
        XCTAssertTrue(loginButton.isHittable)
        
        loginButton.tap()
    }
    
}
