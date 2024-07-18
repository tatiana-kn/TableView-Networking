//
//  ViewController.swift
//  TableView+Networking
//
//  Created by Tia M on 7/1/24.
//

import UIKit

final class ViewController: UIViewController {
    
    private let networkManager = NetworkManager.shared
    private var users: [User] = []
    private let url = URL(string: "https://dummyjson.com/users")!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        fetchUsers()
    }
}

extension ViewController {
    private func setupViews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let user = users[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = user.fullName
        content.secondaryText = user.username
        cell.contentConfiguration = content
        return cell
    }
}

extension ViewController {
    private func fetchUsers() {
        networkManager.fetchUser(from: url) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let users):
                self.users = users.users
                tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

#Preview(traits: .portrait) {
    ViewController()
}

