//
//  UsersConfigurator.swift
//  TableView+Networking
//
//  Created by Tia M on 7/24/24.
//

import Foundation

final class UsersConfigurator {
    
    func configure() -> UsersViewController {
        
        let decoder = JSONDecoder()
        let networkClient = NetworkClient()
        let usersLoader = UsersLoader(networkClient: networkClient, decoder: decoder)
        
        let viewModel = UsersViewModel(usersLoader: usersLoader)

        let viewController = UsersViewController(viewModel: viewModel)

        return viewController
    }
}
