//
//  DetailsPresenter.swift
//  TableView+Networking
//
//  Created by Tia M on 8/16/24.
//

import Foundation

final class DetailsPresenter: DetailsViewOutput, DetailsInteractorOutput {
    var user: User?
    
    var interactor: DetailsInteractorInput?
    weak var view: DetailsViewInput?
    
    func didGetUser(_ user: User?) {
        self.user = user
        view?.update(user)
    }
}
