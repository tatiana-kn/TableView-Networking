//
//  UsersRouter.swift
//  TableView+Networking
//
//  Created by Tia M on 8/16/24.
//

import Foundation

protocol IUsersRouter {
    var view: UsersViewController? { get set }
    
    func navigateToDetailsScreen(_ user: User?)
}

class UsersRouter: IUsersRouter {
    
    weak var view: UsersViewController?
    
    func navigateToDetailsScreen(_ user: User?) {
//        let detailsVC = DetailsConfigurator().configure()
        let detailsVC = DetailsConfigurator().configure(with: user)
        
        view?.present(detailsVC, animated: true)
    }
}
