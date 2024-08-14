//
//  UsersViewViewModel.swift
//  TableView+Networking
//
//  Created by Tia M on 7/24/24.
//

import Foundation

protocol IUsersViewModel {
    
    var users: Observable<[User]> { get set }
    
    func loadUsers()
}

final class UsersViewModel: IUsersViewModel {
    //    var users: [User] = []
    var users: Observable<[User]> = Observable([])
    private var usersLoader: IUsersLoader
    //    var didLoadUsers: (() -> Void)?
    
    init(usersLoader: IUsersLoader) {
        self.usersLoader = usersLoader
    }
    
    func loadUsers() {
        usersLoader.loadUsers { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let users):
                self.users.value = users.users
                //                self.users = users.users
                //                self.didLoadUsers?()
            case .failure(let error):
                print(error)
            }
        }
    }
}

