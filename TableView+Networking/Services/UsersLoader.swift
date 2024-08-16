//
//  UsersLoader.swift
//  TableView+Networking
//
//  Created by Tia M on 7/18/24.
//

import Foundation

protocol UsersLoading {
    func loadUsers(handler: @escaping(Result<Users, Error>) -> Void)
}

struct UsersLoader: UsersLoading {
    private let networkClient: NetworkRouting
    private let decoder: JSONDecoder
    
    init(networkClient: NetworkRouting = NetworkClient(), decoder: JSONDecoder = JSONDecoder()) {
        self.networkClient = networkClient
        self.decoder = decoder
    }

// MARK: - URL
    private var usersURL: URL {
        guard let url = URL(string: "https://dummyjson.com/users") else {
            preconditionFailure("Unable to construct usersURL")
        }
        return url
    }
    
    func loadUsers(handler: @escaping (Result<Users, Error>) -> Void) {
        networkClient.fetch(url: usersURL) { result in
            switch result {
            case .success(let data):
                do {
                    let users = try decoder.decode(Users.self, from: data)
                    handler(.success(users))
                } catch {
                    handler(.failure(error))
                }
                
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
}
