//
//  UsersInteractor.swift
//  TableView+Networking
//
//  Created by Tia M on 8/22/24.
//

import Foundation

protocol UsersInteractorInput: AnyObject {
    var presenter:  UsersInteractorOutput? { get set }
    
    func loadUsers()
}

protocol UsersInteractorOutput: AnyObject {
    
    var view: UsersViewInput? { get set }
    var router: IUsersRouter? { get set }
    var interactor: UsersInteractorInput? { get set }
    
    func loadedUsers(_ users: [User])
}

final class UsersInteractor: UsersInteractorInput {
    
    weak var presenter: UsersInteractorOutput?
    var usersLoader: IUsersLoader = UsersLoader()
}

extension UsersInteractor {
    
    func loadUsers() {
        usersLoader.loadUsers { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let users):
                DispatchQueue.main.async {
                    self.presenter?.loadedUsers(users)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
