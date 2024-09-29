//
//  DetailsInteractor.swift
//  TableView+Networking
//
//  Created by Tia M on 9/28/24.
//

import Foundation

protocol DetailsInteractorInput: AnyObject {
    var presenter:  DetailsInteractorOutput? { get set }
    
    func getUser(_ user: User?)
}

protocol DetailsInteractorOutput: AnyObject {
    var view: DetailsViewInput? { get set }
    var interactor: DetailsInteractorInput? { get set }
    
    func didGetUser(_ user: User?)
}

final class DetailsInteractor: DetailsInteractorInput {
    weak var presenter: DetailsInteractorOutput?
    
    func getUser(_ user: User?) {
        presenter?.didGetUser(user)
    }
}
