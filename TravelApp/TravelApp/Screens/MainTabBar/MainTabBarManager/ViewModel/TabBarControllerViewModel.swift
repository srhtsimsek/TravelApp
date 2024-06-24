//
//  TabBarControllerViewModel.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 4.06.2024.
//

import Firebase

class TabBarControllerViewModel {
    var user: UserModel? {
        didSet {
            userDidChange?(user)
        }
    }
    
    var userDidChange: ((UserModel?) -> Void)?
    
    func checkUserIsLogin() {
        if Auth.auth().currentUser == nil {
            self.userDidChange?(nil)
        } else {
            fetchUser()
        }
    }
    
    private func fetchUser() {
        UserService.shared.fetchUser { [weak self] user in
                self?.user = user
        }
    }
}
