//
//  NewsListPresenter.swift
//  Viper Architecture
//
//  Created by Minata on 15/12/2023.
//

import RxSwift
import RxCocoa
import Foundation

class NewsListPresenter: NewsListViewToPresenterProtocol {
    
    var view: NewsListPresenterToViewProtocol?
    var interactor: NewsListPresenterToInteractorProtocol?
    var router: NewsListPresenterToRouterProtocol?
    private let disposeBag = DisposeBag()
    
    init(view: NewsListPresenterToViewProtocol, interactor: NewsListPresenterToInteractorProtocol, router: NewsListPresenterToRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func updateView(source: String) {
        interactor?.fetchNewsList(source: source)
            .subscribe(
                onNext: { [weak self] fetchedNews in
                    self?.newsListFetched(newsData: fetchedNews)
                }, onError: { [weak self] error in
                    self?.newsListFetchedFailed()
                }
            ).disposed(by: disposeBag)
    }
    
    func getNewsListCount() -> Int? {
        interactor?.newsListDatas?.count
    }
    
    func getNewsList(at index: Int) -> NewsListEntity? {
        interactor?.newsListDatas?[index]
    }
}

extension NewsListPresenter: NewsListInteractorToPresenterProtocol {
    
    func newsListFetched(newsData: NewsResponse?) {
        interactor?.newsListDatas = newsData?.results
        view?.reloadData.accept(())
    }
    
    func newsListFetchedFailed() {
        view?.showError.accept(())
    }
    
}
