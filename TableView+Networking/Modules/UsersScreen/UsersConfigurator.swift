//
//  UsersConfigurator.swift
//  TableView+Networking
//
//  Created by Tia M on 8/16/24.
//

import Foundation

final class UsersConfigurator {
    
    func configure() -> UsersViewController {
        
        let controller = UsersViewController()
        
        let networkClient = NetworkClient()
        let decoder = JSONDecoder()
        
        controller.usersLoader = UsersLoader.init(networkClient: networkClient, decoder: decoder)
        
        return controller
    }
}
