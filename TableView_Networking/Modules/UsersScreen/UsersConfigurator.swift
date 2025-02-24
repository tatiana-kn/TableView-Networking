//
//  UsersConfigurator.swift
//  TableView+Networking
//
//  Created by Tia M on 8/16/24.
//

import Foundation

class UsersConfigurator {
    func configure() -> UsersViewController {
        let usersLoader = UsersLoader()
        let usersPresenter = UsersPresenter(usersLoader: usersLoader)
        let usersVC = UsersViewController(presenter: usersPresenter)
        let usersRouter = UsersRouter()
        
        usersVC.presenter = usersPresenter
        usersPresenter.view = usersVC
        
        usersPresenter.router = usersRouter
        
        usersRouter.view = usersVC
        
        return usersVC
    }
}

//final class UsersConfigurator {
//    
//    func configure() -> UsersViewController {
//        
//        let controller = UsersViewController()
//        
//        let networkClient = NetworkClient()
//        let decoder = JSONDecoder()
//        
//        controller.usersLoader = UsersLoader.init(networkClient: networkClient, decoder: decoder)
//        
//        return controller
//    }
//}
