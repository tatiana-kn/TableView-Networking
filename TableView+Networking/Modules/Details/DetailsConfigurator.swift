//
//  DetailsConfigurator.swift
//  TableView+Networking
//
//  Created by Tia M on 8/17/24.
//

import Foundation

final class DetailsConfigurator {
    
    func configure(_ user: Observable<User>) -> DetailsViewController {
        let viewModel = DetailsViewModel(user: user)
        let detailsVC = DetailsViewController(viewModel: viewModel)
        return detailsVC
    }
}
