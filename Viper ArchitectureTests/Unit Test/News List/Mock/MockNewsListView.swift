//
//  MockNewsListView.swift
//  Viper ArchitectureTests
//
//  Created by Minata on 28/12/2023.
//

import UIKit
import XCTest
import RxSwift
import RxCocoa
@testable import Viper_Architecture

class MockNewsListView: UIViewController, NewsListPresenterToViewProtocol {
    
    var reloadDataCalled = false
    var fetchedNewsData: NewsResponse?
    var showError = PublishRelay<Void>()
    var reloadData = PublishRelay<Void>()
    var reloadDataFailedCalled = false
 
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureObservable()
    }
    
    private func configureObservable() {
        reloadData.subscribe(onNext: { [weak self] in
            self?.reloadDataCalled = true
        }).disposed(by: disposeBag)
        
        showError.subscribe(onNext: { [weak self] in
            self?.reloadDataFailedCalled = true
        }).disposed(by: disposeBag)
    }
    
}
