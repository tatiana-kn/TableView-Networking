//
//  User.swift
//  TableView+Networking
//
//  Created by Tia M on 7/1/24.
//

import Foundation

struct Users: Decodable {
    let users: [User]
}
struct User: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let username: String
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}

