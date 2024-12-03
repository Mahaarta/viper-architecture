//
//  RegisterInteractor.swift
//  Viper Architecture
//
//  Created by Minata on 19/12/2023.
//

import Foundation
import Alamofire
import RxSwift

class RegisterInteractor: RegisterPresenterToInteractorProtocol {
    var presenter: RegisterInteractorToPresenterProtocol?
    var RegisterSuccess: Bool?
    
    private func getPath() -> String {
        return RegisterBaseEndpoint.getBasePath() + "v1/"
    }
    
    func registerProcess(name: String, email: String, password: String, avatar: String) -> Observable<RegisterEntity?> {
        let endpoint = URL(string: getPath() + "users")!
        let parameters: [String: Any] = ["name": name, "password": password, "email": email, "avatar": avatar]
        
        let data: Observable<RegisterEntity?> = NetworkManager.shared.excuteQueryWithEncoding(
            url: endpoint,
            method: .post,
            encoding: JSONEncoding.default,
            parameters: parameters
        )

        return data
    }
}
