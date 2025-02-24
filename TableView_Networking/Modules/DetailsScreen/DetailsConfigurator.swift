//
//  DetailsConfigurator.swift
//  TableView+Networking
//
//  Created by Tia M on 8/16/24.
//

import Foundation

class DetailsConfigurator {
    func configure() -> DetailsViewController {
        let detailsVC = DetailsViewController()
        let detailsPresenter = DetailsPresenter()
        
        detailsVC.presenter = detailsPresenter
        detailsPresenter.view = detailsVC
        
        return detailsVC
    }
}
