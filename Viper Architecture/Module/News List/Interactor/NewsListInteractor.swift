//
//  NewsListInteractor.swift
//  Viper Architecture
//
//  Created by Minata on 15/12/2023.
//

import Foundation
import Alamofire
import RxSwift

class NewsListInteractor: NewsListPresenterToInteractorProtocol {
    
    var presenter: NewsListInteractorToPresenterProtocol?
    var newsListDatas: [NewsListEntity]?
    
    /// Get `Base Endpoint`
    private func getPath() -> String {
        return NewsListBaseEndpoint.getBasePath() + "1/news"
    }
    
    /// - Parameters:
    ///   - source in String for query spesific topic
    func fetchNewsList(source: String) -> Observable<NewsResponse?> {
        let endpoint = URL(string: getPath())!
        let parameters: [String: Any] = ["q": source, "apikey": Constants.NEWS_API_KEY] /// use key chain for api key later
        
        let data: Observable<NewsResponse?> = NetworkManager.shared.excuteQuery(
            url: endpoint,
            method: .get,
            parameters: parameters
        )
        
        return data
    }
    
}
