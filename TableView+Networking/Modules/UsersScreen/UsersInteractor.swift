//
//  UsersInteractor.swift
//  TableView+Networking
//
//  Created by Tia M on 8/22/24.
//

import Foundation

protocol IUsersInteractor {
    var presenter: IUsersPresenter? { get set }
    
    var users: [User] { get set }
    
    func loadUsers()
}

final class UsersInteractor: IUsersInteractor {
    
    weak var presenter: IUsersPresenter?
    var users: [User] = []
    var usersLoader: IUsersLoader = UsersLoader()
}

extension UsersInteractor {
    
     func loadUsers() {
        usersLoader.loadUsers { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let users):
                self.users = users.users
                
                DispatchQueue.main.async {
                    //self.tableView.reloadData()
//                    self.view?.reloadTable()
                    self.presenter?.view?.reloadTable()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
