//
//  UserCell.swift
//  TableView+Networking
//
//  Created by Tia M on 7/28/24.
//

import UIKit

final class UserCell: UITableViewCell {
    static let reuseID = "UserCell"
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private let userFullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "UserFullName"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ user: User) {
        userFullNameLabel.text = user.fullName
        userNameLabel.text = user.username
    }
    
}

extension UserCell {
    func setupViews() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(userFullNameLabel)
        stackView.addArrangedSubview(userNameLabel)
    }
    
    func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

#Preview(traits: .portrait) {
    UserCell()
}
