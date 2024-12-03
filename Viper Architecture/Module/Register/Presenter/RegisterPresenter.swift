//
//  RegisterPresenter.swift
//  Viper Architecture
//
//  Created by Minata on 19/12/2023.
//

import RxSwift
import RxCocoa

class RegisterPresenter: RegisterViewToPresenterProtocol {
    
    var view: RegisterPresenterToViewProtocol?
    var interactor: RegisterPresenterToInteractorProtocol?
    var router: RegisterPresenterToRouterProtocol?
    private let disposeBag = DisposeBag()
    
    init(view: RegisterPresenterToViewProtocol, interactor: RegisterPresenterToInteractorProtocol, router: RegisterPresenterToRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func registerProcess(name: String, email: String, password: String, avatar: String) {
        interactor?.registerProcess(name: name, email: email, password: password, avatar: avatar)
            .subscribe(
                onNext: { [weak self] loginEntity in
                    self?.registerSuccess()
                },
                onError: { [weak self] error in
                    self?.registerFailed(error: error)
                }
            ).disposed(by: disposeBag)
    }
    
}

extension RegisterPresenter: RegisterInteractorToPresenterProtocol {
    
    func registerSuccess() {
        view?.registerSuccess.accept(())
    }
    
    func registerFailed(error: Error) {
        view?.registerFailed.accept(())
    }
    
}
