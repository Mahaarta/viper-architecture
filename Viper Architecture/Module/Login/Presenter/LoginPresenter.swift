//
//  LoginPresenter.swift
//  Viper Architecture
//
//  Created by Minata on 18/12/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Foundation

class LoginPresenter: LoginViewToPresenterProtocol {
    
    var view: LoginPresenterToViewProtocol?
    var interactor: LoginPresenterToInteractorProtocol?
    var router: LoginPresenterToRouterProtocol?
    private let disposeBag = DisposeBag()
    
    init(view: LoginPresenterToViewProtocol, interactor: LoginPresenterToInteractorProtocol, router: LoginPresenterToRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func loginProcess(username: String, password: String) {
        interactor?.loginProcess(username: username, password: password)
            .subscribe(
                onNext: { [weak self] loginEntity in
                    self?.loginSuccess(loginEntity: loginEntity)
                },
                onError: { [weak self] error in
                    self?.loginFailed(error: error)
                }
            ).disposed(by: disposeBag)
    }
    
    func navigateToRegister() {
        router?.navigateToRegister(from: view)
    }
    
    func navigateToDashboard() {
        router?.navigateToDashboard(from: view)
    }
}

extension LoginPresenter: LoginInteractorToPresenterProtocol {
    func loginSuccess(loginEntity: LoginEntity?) {
        view?.loginSuccess.accept(())
    }
    
    func loginFailed(error: Error) {
        view?.showError.accept(())
    }
}
