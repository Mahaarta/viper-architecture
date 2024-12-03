//
//  LoginPresenterToViewProtocol.swift
//  Viper Architecture
//
//  Created by Minata on 19/12/2023.
//

import RxSwift
import RxCocoa

protocol LoginPresenterToViewProtocol: Any {
    
    var loginSuccess: PublishRelay<Void> { get }
    var showError: PublishRelay<Void> { get }
    var navigateToRegister: PublishRelay<Void> { get }
    var navigateToDashboard: PublishRelay<Void> { get }
    
}
