//
//  FirebaseConstants.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 24.06.2024.
//

import Firebase

extension Constants {
    final class FirebaseConstants {
        
        /// Firestore.firestore().collection("users")
        static let COLLECTION_USERS = Firestore.firestore().collection("users")

        /// Firestore.firestore().collection("followers")
        static let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")

        /// Firestore.firestore().collection("following")
        static let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")
    }
}

