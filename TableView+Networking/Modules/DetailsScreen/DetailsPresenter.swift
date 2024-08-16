//
//  DetailsPresenter.swift
//  TableView+Networking
//
//  Created by Tia M on 8/16/24.
//

import Foundation

protocol IDetailsPresenter: AnyObject {
    var view: IDetailsViewController? { get set }
}

final class DetailsPresenter: IDetailsPresenter {
    weak var view: IDetailsViewController?
}
