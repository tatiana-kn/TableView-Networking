//
//  UsersPresenter.swift
//  TableView+Networking
//
//  Created by Tia M on 8/16/24.
//

import Foundation

final class UsersPresenter: UsersViewOutput, InteractorOutput {
    
    var users: [User] = []
    
    var interactor: InteractorInput?
    var usersLoader: IUsersLoader = UsersLoader()
    var router: IUsersRouter?
    weak var view: UsersViewInput?
    
    func viewDidLoad() {
        interactor?.loadUsers()
    }
    
    func getUsersCount() -> Int {
        users.count
    }
    
    func getUser(index: Int) -> User {
        let user = users[index]
        return user
    }
    
    func userCellSelected(index: Int) {
        let user = users[index]
        router?.navigateToDetailsScreen(user)
    }
    
    func loadedUsers(_ users: [User]) {
        self.users = users
        view?.reloadTable()
    }
}

