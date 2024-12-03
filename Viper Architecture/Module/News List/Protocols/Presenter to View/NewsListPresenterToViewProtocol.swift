//
//  NewsListPresenterToViewProtocol.swift
//  Viper Architecture
//
//  Created by Minata on 15/12/2023.
//

import RxSwift
import RxCocoa
import Foundation

protocol NewsListPresenterToViewProtocol: Any {
    
    var reloadData: PublishRelay<Void> { get }
    var showError: PublishRelay<Void> { get }
    
}
