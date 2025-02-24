//
//  User.swift
//  TableView+Networking
//
//  Created by Tia M on 7/1/24.
//

import Foundation

struct Users: Codable {
    let users: [User]
}

struct User: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let username: String
    let email: String
    let phone: String
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}

struct MockUser {
    var users: [User] = [
        User(id: 1, firstName: "John", lastName: "Doe", username: "johndoe", email: "aaa@mail.com", phone: "1234567"),
        User(id: 2, firstName: "Jane", lastName: "Doe", username: "janedoe", email: "bbb@mail.com", phone: "2345678")
    ]
    
    func loadUsers() {
    }
}
