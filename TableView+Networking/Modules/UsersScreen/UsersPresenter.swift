//
//  UsersPresenter.swift
//  TableView+Networking
//
//  Created by Tia M on 8/16/24.
//

import Foundation

//protocol IUsersPresenter: AnyObject {
////    var view: IUsersViewController? { get set }
//    
////    var view: UsersViewInput? { get set }
////    var router: IUsersRouter? { get set }
////    var interactor: InteractorInput? { get set }
//    
////    //Events
////    func viewDidLoad()
////    
////    func userCellSelected(index: Int)
//    
//    //Datasource
////    func getUsersCount() -> Int
////    
////    func getUser(index: Int) -> User
//}


final class UsersPresenter: UsersViewOutput, InteractorOutput {
    //var presenter: (any UsersViewOutput)?
    var users: [User] = []
    
    var interactor: InteractorInput?
    var usersLoader: IUsersLoader = UsersLoader()
    var router: IUsersRouter?
//    weak var view: IUsersViewController?
    weak var view: UsersViewInput?
    
    func viewDidLoad() {
//        loadUsers()
        interactor?.loadUsers()
    }
    
    func getUsersCount() -> Int {
//        return users.count
//        return interactor?.users.count ?? 0
        return users.count
    }
    
    func getUser(index: Int) -> User {
//        return users[index]
//        guard let user = interactor?.users[index] else {
//            fatalError("Unable to identify user")
//        }
        let user = users[index]
        return user
    }
    
    func userCellSelected(index: Int) {
//        let user = users[index]
//        let user = interactor?.users[index]
        let user = users[index]
        router?.navigateToDetailsScreen(user)
    }
    
    func loadedUsers(_ users: [User]) {
        self.users = users
        view?.reloadTable()
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
