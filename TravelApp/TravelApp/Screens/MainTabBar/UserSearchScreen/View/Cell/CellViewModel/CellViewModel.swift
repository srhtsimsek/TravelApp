//
//  CellViewModel.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 4.06.2024.
//

import Foundation

struct CellViewModel {
    private var user: UserModel
    
    var fullName: String {
        return user.fullName
    }
    
    var username: String {
        return user.username
    }
    
    init(user: UserModel) {
        self.user = user
    }
}
