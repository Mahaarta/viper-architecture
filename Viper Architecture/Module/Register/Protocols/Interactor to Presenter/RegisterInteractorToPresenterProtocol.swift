//
//  RegisterInteractorToPresenterProtocol.swift
//  Viper Architecture
//
//  Created by Minata on 19/12/2023.
//

protocol RegisterInteractorToPresenterProtocol: Any {
    
    func registerSuccess()
    func registerFailed(error: Error)
    
}
