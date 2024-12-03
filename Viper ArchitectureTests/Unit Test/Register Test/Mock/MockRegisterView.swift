//
//  MockRegisterView.swift
//  Viper ArchitectureTests
//
//  Created by Minata on 03/01/2024.
//

import XCTest
import RxSwift
import RxCocoa
@testable import Viper_Architecture

final class MockRegisterView: UIViewController, RegisterPresenterToViewProtocol {
    
    var registerSuccess = PublishRelay<Void>()
    var registerFailed = PublishRelay<Void>()
    var registerSuccessCalled = false
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureObservable()
    }
    
    private func configureObservable() {
        registerSuccess.subscribe(onNext: { [weak self] in
            self?.registerSuccessCalled = true
        }).disposed(by: disposeBag)
    }
    
}
