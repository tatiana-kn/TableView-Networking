//
//  UsersConfigurator.swift
//  TableView+Networking
//
//  Created by Tia M on 8/16/24.
//

import Foundation

class UsersConfigurator {
    func configure() -> UsersViewController {
        let usersVC = UsersViewController()
        let usersPresenter = UsersPresenter()
        let usersInteractor = UsersInteractor()
        let usersRouter = UsersRouter()
        
        usersVC.presenter = usersPresenter
        usersPresenter.view = usersVC
        usersPresenter.interactor = usersInteractor
        usersInteractor.presenter = usersPresenter
        usersPresenter.router = usersRouter
        
        usersRouter.view = usersVC
        
        return usersVC
    }
}

