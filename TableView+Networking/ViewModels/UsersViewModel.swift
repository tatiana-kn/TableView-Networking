//
//  UsersViewViewModel.swift
//  TableView+Networking
//
//  Created by Tia M on 7/24/24.
//

import Foundation

class UsersViewModel  {
    //    var users: [User] = []
    var users: Observable<[User]> = Observable([])
    var usersLoader: UsersLoading = UsersLoader()
    //    var didLoadUsers: (() -> Void)?
    
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

