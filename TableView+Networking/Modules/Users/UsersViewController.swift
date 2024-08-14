//
//  ViewController.swift
//  TableView+Networking
//
//  Created by Tia M on 7/1/24.
//

import UIKit

final class UsersViewController: UIViewController {
    
    var viewModel: IUsersViewModel
    
    init(viewModel: IUsersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        viewModel.loadUsers()
        
        setupBindings()
    }
}

extension UsersViewController {
    func setupBindings() {
        viewModel.users.bind { [weak self] _ in
            guard let self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension UsersViewController {
    private func setupViews() {
        view.backgroundColor = .white
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
        viewModel.users.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseID, for: indexPath) as? UserCell else {
            return UITableViewCell()
        }
        if let user = viewModel.users.value?[indexPath.row] {
            cell.update(user)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let user = viewModel.users.value?[indexPath.row] {
            let viewModel = DetailsViewModel(user: Observable(user))
            let detailsVC = DetailsViewController(viewModel: viewModel)
            present(detailsVC, animated: true)
        }
    }
}

#Preview(traits: .portrait) {
    UsersViewController(viewModel: MockUser())
}


