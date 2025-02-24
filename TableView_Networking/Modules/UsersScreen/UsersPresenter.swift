//
//  UsersPresenter.swift
//  TableView+Networking
//
//  Created by Tia M on 8/16/24.
//

import Foundation

protocol IUsersPresenter: AnyObject {
    var view: IUsersViewController? { get set }
    var router: IUsersRouter? { get set }
    
    //Events
    func viewDidLoad()
    
    func userCellSelected(index: Int)
    
    //Datasource
    func getUsersCount() -> Int
    
    func getUser(index: Int) -> User
}

final class UsersPresenter: IUsersPresenter {
    
    var usersLoader: UsersLoading = UsersLoader()
    
    var users: [User] = []
    
    var router: IUsersRouter?
    
    weak var view: IUsersViewController?
    
    func viewDidLoad() {
        loadUsers()
    }
    
    func getUsersCount() -> Int {
        return users.count
    }
    
    func getUser(index: Int) -> User {
        return users[index]
    }
    
    func userCellSelected(index: Int) {
        let user = users[index]
        router?.navigateToDetailsScreen(user)
    }
}

extension UsersPresenter {
    
    private func loadUsers() {
        usersLoader.loadUsers { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let users):
                self.users = users.users
                
                DispatchQueue.main.async {
                    //self.tableView.reloadData()
                    self.view?.reloadTable()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
