//
//  NewsListViewController.swift
//  Viper Architecture
//
//  Created by Minata on 15/12/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

class NewsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var showError = PublishRelay<Void>()
    let reloadData = PublishRelay<Void>()
    var presenter: NewsListViewToPresenterProtocol?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = News.newsList
        
        setUpTableView()
        configureObservable()
        confifureLoadingSpinner()
        presenter?.updateView(source: "tech")
    }
    
    /// Configure `Observable`
    private func configureObservable() {
        reloadData.subscribe(onNext: { [weak self] in
            self?.confifureLoadingSpinner(isLoading: false)
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        showError.subscribe(onNext: { [weak self] in
            self?.showErrorAlert()
        }).disposed(by: disposeBag)
    }
    
    /// Configure `TableView`
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.accessibilityIdentifier = "newsListTableViewIdentifier"
        tableView.register(UINib(nibName: "NewsListTableViewCell", bundle: .main), forCellReuseIdentifier: "NewsListTableViewCell")
    }
    
    /// Configure `Loading Spinner`
    private func confifureLoadingSpinner(isLoading: Bool = true) {
        if isLoading {
            spinner.isHidden = false
            spinner.startAnimating()
        } else {
            spinner.isHidden = true
            spinner.stopAnimating()
        }
    }
    
    /// Configure `Alert View`
    private func showErrorAlert() {
        let alert = UIAlertController(
            title: Application.whoops,
            message: News.problemFetchingNews,
            preferredStyle: UIAlertController.Style.alert
        )
        
        alert.view.accessibilityIdentifier = "ErrorAlert"
        alert.addAction(UIAlertAction(
            title: Application.okay,
            style: UIAlertAction.Style.default,
            handler: nil)
        )
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
// MARK: - TableView DataSource
extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getNewsListCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListTableViewCell", for: indexPath) as? NewsListTableViewCell
        let row = indexPath.row
        let news = presenter?.getNewsList(at: row)
        
        guard let title = news?.title, let description = news?.description else {
            return cell ?? UITableViewCell()
        }
        
        cell?.setCell(title: title, description: description)
        return cell ?? UITableViewCell()
    }
}

// MARK: Presenter to View
extension NewsListViewController: NewsListPresenterToViewProtocol {
}

// MARK: Localization
extension NewsListViewController {
    struct Application {
        static let nice = localizedString(StructLocalization.Application.nice)
        static let back = localizedString(StructLocalization.Application.back)
        static let okay = localizedString(StructLocalization.Application.back)
        static let whoops = localizedString(StructLocalization.Application.whoops)
    }
    
    struct News {
        static let newsList = localizedString(StructLocalization.News.newsList)
        static let problemFetchingNews = localizedString(StructLocalization.News.problemFetchingNews)
    }
    
}
