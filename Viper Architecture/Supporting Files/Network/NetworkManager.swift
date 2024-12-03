//
//  NetworkManager.swift
//  Viper Architecture
//
//  Created by Minata on 22/12/2023.
//

import Foundation
import Alamofire
import RxSwift

protocol NetworkManagerProtocol: Any {
    func excuteQuery<T>(
        url: URL,
        method: HTTPMethod, 
        parameters: Parameters?
    ) -> Observable<T> where T: Codable
    
    func excuteQueryWithEncoding<T>(
        url: URL,
        method: HTTPMethod,
        encoding: JSONEncoding,
        parameters: Parameters?,
        additionalHeaders: HTTPHeaders?
    ) -> Observable<T> where T: Codable
}

class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()
    
    func excuteQuery<T>(url: URL, method: HTTPMethod, parameters: Parameters?) -> RxSwift.Observable<T> where T: Codable {
        return Observable.create({ observer in
            let headers: HTTPHeaders = [
                "Accept": "application/json",
                "Content-Type": "application/json"
            ]
            
            AF.request(url, method: method, parameters: parameters, headers: headers)
                .validate(statusCode: 200...299)
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            
            return Disposables.create()
        })
    }
    
    /// - Parameters:
    ///     - url: given url to excute
    ///     - method: use HTTPMethod type
    ///     - encoding: type of JSONEncoding, default value is (.default)
    ///     - params: use Parameters type
    ///     - addotionalParams: add additional params based on your need [String : String]
    func excuteQueryWithEncoding<T> (
        url: URL,
        method: HTTPMethod,
        encoding: JSONEncoding = .default,
        parameters: Parameters? = nil,
        additionalHeaders: HTTPHeaders? = nil
    ) -> Observable<T> where T: Codable {
        
        return Observable<T>.create({ observer in
            var headers: HTTPHeaders = [
                "Accept": "application/json",
                "Content-Type": "application/json"
            ]
            
            /// If there is any additional params than add it to `Headers`
            if let additionalHeaders {
                additionalHeaders.forEach({ header in
                    headers.add(name: header.name, value: header.value)
                })
            }
            
            AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
                .validate(statusCode: 200...299)
                .responseDecodable(of: T.self) { response in
                    print("responseDecodable \(response.result)")
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            
            return Disposables.create()
        })
    }
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //    /// - Parameters:
//    ///     - url: given url to excute
//    ///     - method: use HTTPMethod type
//    ///     - params: use Parameters type
//    func excuteQuery<T>(
//        url: URL,
//        method: HTTPMethod,
//        parameters: Parameters?
//    ) -> Observable<T> where T: Codable {
//        
//        return Observable.create({ observer in
//            let headers: HTTPHeaders = [
//                "Accept": "application/json",
//                "Content-Type": "application/json"
//            ]
//            
//            AF.request(url, method: method, parameters: parameters, headers: headers)
//                .validate(statusCode: 200...299)
//                .responseDecodable(of: T.self) { response in
//                    switch response.result {
//                    case .success(let value):
//                        observer.onNext(value)
//                        observer.onCompleted()
//                    case .failure(let error):
//                        observer.onError(error)
//                    }
//                }
//            
//            return Disposables.create()
//        })
//    }
//    
//    /// - Parameters:
//    ///     - url: given url to excute
//    ///     - method: use HTTPMethod type
//    ///     - encoding: type of JSONEncoding, default value is (.default)
//    ///     - params: use Parameters type
//    ///     - addotionalParams: add additional params based on your need [String : String]
//    func excuteQueryWithEncoding<T> (
//        url: URL,
//        method: HTTPMethod,
//        encoding: JSONEncoding,
//        parameters: Parameters? = nil,
//        additionalHeaders: [String : String]? = nil
//    ) -> Observable<T> where T: Codable {
//        
//        return Observable<T>.create({ observer in
//            var headers: HTTPHeaders = [
//                "Accept": "application/json",
//                "Content-Type": "application/json"
//            ]
//            
//            /// If there is any additional params than add it to `Headers`
//            if let additionalHeaders {
//                additionalHeaders.forEach({ header in
//                    headers.add(name: header.key, value: header.value)
//                })
//            }
//            
//            AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
//                .validate(statusCode: 200...299)
//                .responseDecodable(of: T.self) { response in
//                    print("responseDecodable \(response.result)")
//                    switch response.result {
//                    case .success(let value):
//                        observer.onNext(value)
//                        observer.onCompleted()
//                    case .failure(let error):
//                        observer.onError(error)
//                    }
//                }
//            
//            return Disposables.create()
//        })
//    }
    
}
