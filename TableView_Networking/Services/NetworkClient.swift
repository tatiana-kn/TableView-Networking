//
//  NetworkClient.swift
//  TableView+Networking
//
//  Created by Tia M on 7/18/24.
//

import Foundation

protocol INetworkClient {
    func fetch(url: URL, handler: @escaping(Result<Data, Error>) -> Void)
}

struct NetworkClient: INetworkClient {
    
    private enum NetworkError: Error {
        case codeError
    }
    
    func fetch(url: URL, handler: @escaping (Result<Data, Error>) -> Void) {
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error {
                handler(.failure(error))
                return
            }
            
            if let response = response as? HTTPURLResponse,
               response.statusCode < 200 || response.statusCode >= 300 {
                handler(.failure(NetworkError.codeError))
                return
            }
            
            guard let data else { return }
            handler(.success(data))
        }
        task.resume()
    }
}
