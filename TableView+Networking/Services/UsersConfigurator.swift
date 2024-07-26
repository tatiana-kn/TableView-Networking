//
//  UsersConfigurator.swift
//  TableView+Networking
//
//  Created by Tia M on 7/24/24.
//

import Foundation

final class UsersConfigurator {
    
    func configure() -> UsersViewController {
        
        let controller = UsersViewController()
        
        let networkClient = NetworkClient()
        let decoder = JSONDecoder()
        
        controller.viewModel.usersLoader = UsersLoader.init(networkClient: networkClient, decoder: decoder)
//        controller.usersLoader = UsersLoader.init(networkClient: networkClient, decoder: decoder)
        
        return controller
    }
}
