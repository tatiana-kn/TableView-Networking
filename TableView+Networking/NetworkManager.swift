//
//  NetworkManager.swift
//  TableView+Networking
//
//  Created by Tia M on 7/1/24.
//

import Foundation

enum NetworkError: Error {
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchUser(from url: URL, completion: @escaping(Result<Users, NetworkError>) -> Void ) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                print(error ?? "No error description")
                return
            }
            do {
                let users = try JSONDecoder().decode(Users.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(users))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
