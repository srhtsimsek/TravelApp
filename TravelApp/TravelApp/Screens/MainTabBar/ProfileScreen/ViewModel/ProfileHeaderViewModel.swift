//
//  ProfileHeaderViewModel.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 30.05.2024.
//

import UIKit
import Firebase

class ProfileHeaderViewModel {
    var user: UserModel
    
    var uid: String? {
        return user.uid
    }
    var username: String {
        return user.username
    }
    var fullName: String {
        return user.fullName
    }
    var email: String {
        return user.email
    }
    var isCurrentUser: Bool {
        return Auth.auth().currentUser?.uid == uid
    }

    var followButtonText: String? {
        if isCurrentUser {
            return "Edit Profile"
        }
        return controlUserFollowing()
    }
    var followButtonColor: UIColor {
        if !isCurrentUser {
            return .systemBlue
        }
        return .lightGray
    }
    
    init(user: UserModel) {
        self.user = user
    }
    
    func controlUserFollowing() -> String {
        guard let isFollowing = user.isFollowing else { return "hata" }
        return isFollowing ? "Takip Ediliyor" : "Takip Et"
    }
}
