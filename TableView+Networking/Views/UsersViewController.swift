//
//  ViewController.swift
//  TableView+Networking
//
//  Created by Tia M on 7/1/24.
//

import UIKit

final class UsersViewController: UIViewController {
    
    var viewModel = UsersViewModel()
    //    private var users: [User] = []
    //    var usersLoader: UsersLoading = UsersLoader()
    
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
        viewModel.loadUsers()
        
        viewModel.users.bind { [weak self] _ in
            guard let self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        //        viewModel.didLoadUsers = {
        //            DispatchQueue.main.async { [weak self] in
        //                guard let self else { return }
        //                self.tableView.reloadData()
        //            }
        //        }
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
        //        viewModel.users.count
        viewModel.users.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //        let user = viewModel.users[indexPath.row]
        if let user = viewModel.users.value?[indexPath.row] {
            var content = cell.defaultContentConfiguration()
            content.text = user.fullName
            content.secondaryText = user.username
            cell.contentConfiguration = content
        }
        return cell
    }
}

//extension UsersViewController {
//
//    private func loadUsers() {
//        usersLoader.loadUsers { [weak self] result in
//            guard let self else { return }
//            switch result {
//            case .success(let users):
//                self.users = users.users
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//}

#Preview(traits: .portrait) {
    UsersViewController()
}
