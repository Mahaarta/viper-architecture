//
//  LoginInteractorToPresenterProtocol.swift
//  Viper Architecture
//
//  Created by Minata on 19/12/2023.
//

protocol LoginInteractorToPresenterProtocol: Any {
    
    func loginSuccess(loginEntity: LoginEntity?)
    func loginFailed(error: Error)
    
}
