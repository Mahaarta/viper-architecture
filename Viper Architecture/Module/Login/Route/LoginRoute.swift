//
//  LoginRoute.swift
//  Viper Architecture
//
//  Created by Minata on 18/12/2023.
//

import UIKit

class LoginRoute: LoginPresenterToRouterProtocol {
    
    static func createModule() -> UIViewController {
        let router = LoginRoute()
        let view = LoginViewController()
        let interactor = LoginInteractor()
        let presenter = LoginPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    func navigateToRegister(from view: LoginPresenterToViewProtocol?) {
        let vc = RegisterRoute.createModule()
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func navigateToDashboard(from view: LoginPresenterToViewProtocol?) {
        let vc = NewsListRoute.createModule()
        removeAllViewControllerExceptLast(view, lastView: vc)
    }
    
    func removeAllViewControllerExceptLast(_ view: LoginPresenterToViewProtocol?, lastView: UIViewController) {
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(lastView, animated: true)
            
            guard let navigationController = sourceView.navigationController else { return }
            var navigationArray = navigationController.viewControllers /// To get all UIViewController stack as Array
            navigationArray.remove(at: navigationArray.count - 2)
            sourceView.navigationController?.viewControllers = navigationArray
        }
    }
    
}
