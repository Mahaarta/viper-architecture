//
//  MockNetworkManager.swift
//  Viper ArchitectureTests
//
//  Created by Minata on 22/12/2023.
//

import RxSwift
import Alamofire
import Foundation
@testable import Viper_Architecture

struct MockResponse: Codable, Equatable {
    let message: String
}

class MockNetworkManager: NetworkManagerProtocol {
    var shouldSucceed: Bool = true

    func excuteQuery<T>(url: URL, method: HTTPMethod, parameters: Parameters?) -> Observable<T> where T : Decodable, T : Encodable {
        return Observable.create { observer in
            
            if self.shouldSucceed {
                /// Simulate `Successful Response`
                let mockResponse = MockResponse(message: "Mocked success!")
                do {
                    let encodedData = try JSONEncoder().encode(mockResponse)
                    if let decodedData = try? JSONDecoder().decode(T.self, from: encodedData) {
                        observer.onNext(decodedData)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(error)
                }
                
            } else {
                /// Simulate `Failure Response`
                let error = NSError(domain: "MockErrorDomain", code: 43, userInfo: nil)
                observer.onError(error)
            }

            return Disposables.create()
        }
    }
    
    func excuteQueryWithEncoding<T>(url: URL, method: HTTPMethod, encoding: JSONEncoding, parameters: Parameters?, additionalHeaders: HTTPHeaders?) -> RxSwift.Observable<T> where T : Decodable, T : Encodable {
        return Observable.create { observer in
            
            if self.shouldSucceed {
                /// Simulate `Successful Response`
                let mockResponse = MockResponse(message: "Mocked success!")
                do {
                    let encodedData = try JSONEncoder().encode(mockResponse)
                    if let decodedData = try? JSONDecoder().decode(T.self, from: encodedData) {
                        observer.onNext(decodedData)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(error)
                }
                
            } else {
                /// Simulate `Failure Response`
                let error = NSError(domain: "MockErrorDomain", code: 43, userInfo: nil)
                observer.onError(error)
            }

            return Disposables.create()
        }
    }
}
