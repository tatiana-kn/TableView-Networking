//
//  ViewController.swift
//  TableView+Networking
//
//  Created by Tia M on 7/1/24.
//

import UIKit

protocol IUsersViewController: AnyObject {
    
    var presenter: IUsersPresenter? { get set }
    
    //Update View
    func reloadTable()
    
    //Navigation
    //func navigateToDetailsScreen(_ user: User?)
}

final class UsersViewController: UIViewController, IUsersViewController {

    var presenter: IUsersPresenter?
    
    //var usersLoader: UsersLoading = UsersLoader()
    
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
        
        presenter?.viewDidLoad()
        //loadUsers()
    }
    
    func reloadTable() {
        tableView.reloadData()
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
        //users.count
        presenter?.getUsersCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseID, for: indexPath) as? UserCell else {
            return UITableViewCell()
        }
        //let user = users[indexPath.row]
        
        let user = presenter?.getUser(index: indexPath.row)
        
        cell.update(user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let user = users[indexPath.row]
        //let detailsVC = DetailsViewController()
        
        presenter?.userCellSelected(index: indexPath.row)
        //presenter.didSelectUserCell()
        
        //let user = presenter?.getUser(index: indexPath.row)
        //navigateToDetailsScreen(user)
        
//        let detailsVC = DetailsConfigurator().configure()
//        detailsVC.update(user)
//        present(detailsVC, animated: true)
    }
}

#Preview(traits: .portrait) {
    UsersViewController()
}
