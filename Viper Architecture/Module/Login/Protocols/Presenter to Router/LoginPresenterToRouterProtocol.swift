//
//  LoginPresenterToRouterProtocol.swift
//  Viper Architecture
//
//  Created by Minata on 19/12/2023.
//

import UIKit

protocol LoginPresenterToRouterProtocol: Any {
    
    static func createModule() -> UIViewController
    func navigateToRegister(from view: LoginPresenterToViewProtocol?)
    func navigateToDashboard(from view: LoginPresenterToViewProtocol?)
    
}
