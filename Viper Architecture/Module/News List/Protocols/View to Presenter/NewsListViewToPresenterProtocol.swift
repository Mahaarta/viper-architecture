//
//  NewsListViewToPresenterProtocol.swift
//  Viper Architecture
//
//  Created by Minata on 15/12/2023.
//

protocol NewsListViewToPresenterProtocol: Any {
    
    var view: NewsListPresenterToViewProtocol? { get set }
    var interactor: NewsListPresenterToInteractorProtocol? { get set }
    var router: NewsListPresenterToRouterProtocol? { get set }
    
    func updateView(source: String)
    func getNewsListCount() -> Int?
    func getNewsList(at index: Int) -> NewsListEntity?
}
