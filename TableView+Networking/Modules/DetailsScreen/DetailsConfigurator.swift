//
//  DetailsConfigurator.swift
//  TableView+Networking
//
//  Created by Tia M on 8/16/24.
//

import Foundation

class DetailsConfigurator {
    func configure(with user: User?) -> DetailsViewController {
        let detailsVC = DetailsViewController()
        let detailsPresenter = DetailsPresenter()
        let detailsInteractor = DetailsInteractor()
        
        detailsVC.presenter = detailsPresenter
        detailsPresenter.view = detailsVC
        detailsPresenter.interactor = detailsInteractor
        detailsInteractor.presenter = detailsPresenter
        
        detailsInteractor.getUser(user)
        
        return detailsVC
    }
}
