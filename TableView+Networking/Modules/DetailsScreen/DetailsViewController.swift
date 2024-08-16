//
//  DetailsViewController.swift
//  TableView+Networking
//
//  Created by Tia M on 8/16/24.
//

import UIKit

final class DetailsViewController: UIViewController {
    var user: User?
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "User name"
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .black
        return label
    }()
    
    private var phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "phone"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .gray
        return label
    }()
    
    private var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "email"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    func update(_ user: User?) {
        nameLabel.text = user?.fullName
        phoneLabel.text = user?.phone
        emailLabel.text = user?.email
    }
}

extension DetailsViewController {
    func setupViews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(phoneLabel)
        view.backgroundColor = .white
    }
    
    func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
