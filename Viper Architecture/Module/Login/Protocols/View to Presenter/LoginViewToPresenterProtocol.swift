//
//  LoginViewToPresenterProtocol.swift
//  Viper Architecture
//
//  Created by Minata on 19/12/2023.
//

import UIKit

protocol LoginViewToPresenterProtocol: Any {
    
    var view: LoginPresenterToViewProtocol? { get set }
    var interactor: LoginPresenterToInteractorProtocol? { get set }
    var router: LoginPresenterToRouterProtocol? { get set }
    
    func navigateToRegister()
    func navigateToDashboard()
    func loginProcess(username: String, password: String)
    
}
