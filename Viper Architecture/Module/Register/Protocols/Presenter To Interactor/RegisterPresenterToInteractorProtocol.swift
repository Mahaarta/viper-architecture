//
//  RegisterPresenterToInteractorProtocol.swift
//  Viper Architecture
//
//  Created by Minata on 19/12/2023.
//

import RxSwift

protocol RegisterPresenterToInteractorProtocol: Any {
    
    var presenter: RegisterInteractorToPresenterProtocol? { get set }
    var RegisterSuccess: Bool? { get }
    
    func registerProcess(name: String, email: String, password: String, avatar: String) -> Observable<RegisterEntity?>
    
}
