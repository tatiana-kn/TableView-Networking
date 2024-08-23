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
    
    var interactor: IUsersInteractor? { get set }
    
    //Events
    func viewDidLoad()
    
    func userCellSelected(index: Int)
    
    //Datasource
    func getUsersCount() -> Int
    
    func getUser(index: Int) -> User
}

final class UsersPresenter: IUsersPresenter {
    var interactor: IUsersInteractor?

    var usersLoader: IUsersLoader = UsersLoader()
    
//    var users: [User] = []
    
    var router: IUsersRouter?
    
    weak var view: IUsersViewController?
    
    func viewDidLoad() {
        
//        loadUsers()
        interactor?.loadUsers()
    }
    
    func getUsersCount() -> Int {
//        return users.count
        return interactor?.users.count ?? 0
    }
    
    func getUser(index: Int) -> User {
//        return users[index]
        guard let user = interactor?.users[index] else {
            fatalError("Unable to identify user")
        }
        return user
    }
    
    func userCellSelected(index: Int) {
//        let user = users[index]
        let user = interactor?.users[index]
        router?.navigateToDetailsScreen(user)
    }
}

//extension UsersPresenter {
//    
//    private func loadUsers() {
//        usersLoader.loadUsers { [weak self] result in
//            guard let self else { return }
//            switch result {
//            case .success(let users):
//                self.users = users.users
//                
//                DispatchQueue.main.async {
//                    //self.tableView.reloadData()
//                    self.view?.reloadTable()
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//}
