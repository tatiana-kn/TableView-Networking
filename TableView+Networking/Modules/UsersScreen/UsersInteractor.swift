//
//  UsersInteractor.swift
//  TableView+Networking
//
//  Created by Tia M on 8/22/24.
//

import Foundation

//protocol IUsersInteractor {
//    var presenter: IUsersPresenter? { get set }
//    
//    var users: [User] { get set }
//    
//    func loadUsers()
//}

protocol InteractorInput: AnyObject {
    var presenter:  InteractorOutput? { get set }

    //var users: [User] { get set }
    
    func loadUsers()
}

protocol InteractorOutput: AnyObject {
    
    var view: UsersViewInput? { get set }
    var router: IUsersRouter? { get set }
    var interactor: InteractorInput? { get set }
    
//    //Datasource
//    func getUsersCount() -> Int
//    
//    func getUser(index: Int) -> User
    
    
    func loadedUsers(_ users: [User])
}

final class UsersInteractor: InteractorInput {
    
    weak var presenter: InteractorOutput?
    //var users: [User] = []
    var usersLoader: IUsersLoader = UsersLoader()
}

extension UsersInteractor {
    
     func loadUsers() {
         usersLoader.loadUsers { [weak self] result in
             guard let self else { return }
             switch result {
             case .success(let users):
                 //self.users = users
                 
                 DispatchQueue.main.async {
                     //self.tableView.reloadData()
                     //                    self.view?.reloadTable()
                     //self.presenter?.view?.reloadTable()
                     
                     self.presenter?.loadedUsers(users)
                 }
             case .failure(let error):
                 print(error)
             }
         }
    }
    
}
