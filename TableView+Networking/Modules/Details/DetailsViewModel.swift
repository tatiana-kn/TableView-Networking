//
//  DetailsViewModel.swift
//  TableView+Networking
//
//  Created by Tia M on 8/14/24.
//

import Foundation

protocol IDetailsViewModel {
    var user: Observable<User> { get }
}

final class DetailsViewModel: IDetailsViewModel {
    var user: Observable<User>
    
    init(user: Observable<User>) {
        self.user = user
    }
}
