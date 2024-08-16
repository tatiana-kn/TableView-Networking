//
//  ViewController.swift
//  TableView+Networking
//
//  Created by Tia M on 7/1/24.
//

import UIKit

final class UsersViewController: UIViewController {
    
    private var users: [User] = []
    
    var usersLoader: UsersLoading = UsersLoader()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.reuseID)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        loadUsers()
    }
}

extension UsersViewController {
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

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseID, for: indexPath) as? UserCell else {
            return UITableViewCell()
        }
        let user = users[indexPath.row]
        cell.update(user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let detailsVC = DetailsViewController()
        detailsVC.update(user)
        present(detailsVC, animated: true)
    }
}

extension UsersViewController {

    private func loadUsers() {
        usersLoader.loadUsers { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let users):
                self.users = users.users
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

#Preview(traits: .portrait) {
    UsersViewController()
}
