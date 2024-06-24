//
//  UserModel.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 30.05.2024.
//

import Foundation
import Firebase

struct UserModel: Codable {
    let uid: String?
    let username: String
    let fullName: String
    let email: String
    var isFollowing: Bool? {
        didSet {
            print("heeeeeeey")
        }
    }
}
