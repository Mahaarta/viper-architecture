//
//  LoginPresenterToInteractorProtocol.swift
//  Viper Architecture
//
//  Created by Minata on 19/12/2023.
//

import RxSwift

protocol LoginPresenterToInteractorProtocol: Any {
    
    var presenter: LoginInteractorToPresenterProtocol? { get set }
    var loginSuccess: Bool? { get }
    
    func loginProcess(username: String, password: String) -> Observable<LoginEntity?>
}
