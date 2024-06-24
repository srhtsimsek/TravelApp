//
//  UserService.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 30.05.2024.
//

import FirebaseAuth

struct UserService {
    public static let shared = UserService()
    
    private let userFollowers: String = "userFollowers"
    private let userFollowing: String = "userFollowing"
    
    private init() {}
    
    //MARK: Fetch User
    public func fetchUser(completion: @escaping(UserModel?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = snapshot?.data() else { return }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: data)
                let userModel = try JSONDecoder().decode(UserModel.self, from: jsonData)
                completion(userModel)
            } catch {
                print("Fetch User Error: \(error.localizedDescription)")
            }
        }
    }
    
    //MARK: Fetch All Users
    public func fetchAllUsers(completion: @escaping([UserModel]?) -> Void) {
        COLLECTION_USERS.getDocuments { snapshot, error in
            if let error = error {
                print("Fetch All Users Error: \(error.localizedDescription)")
            }
            
            guard let snapshot = snapshot else { return }
            
            var userList: [UserModel] = []
            
            for document in snapshot.documents {
                let documentData = document.data()
                
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: documentData)
                    let user = try JSONDecoder().decode(UserModel.self, from: jsonData)
                    userList.append(user)
                } catch {
                    print("Fetch All Users Json Serialization Error \(error.localizedDescription)")
                    return
                }
            }
            completion(userList)
        }
    }
    
    //MARK: Follow User
    public func followUser(who uid: String, completion: @escaping(FirebaseCompletionHandler)) {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUserId).collection(userFollowing).document(uid).setData([:]) { error in
            if let error = error {
                print("user could not follow ---> \(error.localizedDescription)")
                return
            }
            COLLECTION_FOLLOWERS.document(uid).collection(userFollowers).document(currentUserId).setData([:]) { error in
                if let error = error {
                    print("followUser func ---> \(error.localizedDescription)")
                    return
                }
            }
        }
    }
    
    //MARK: Unfollow User
    public func unFollowUser(who uid: String, completion: @escaping(FirebaseCompletionHandler)) {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUserId).collection(userFollowing).document(uid).delete { error in
            if let error = error {
                print("user could not unfollowed ---> \(error.localizedDescription)")
                return
            }
            COLLECTION_FOLLOWERS.document(uid).collection(userFollowers).document(currentUserId).delete { error in
                if let error = error {
                    print("unFollowUser func ---> \(error.localizedDescription)")
                    return
                }
            }
        }
        print("user unfollowed.")
    }
    
    public func checkIsUserFollowing(uid: String, completion: @escaping(Bool) -> Void) {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUserId).collection(userFollowing).document(uid).getDocument { snapshot, error in
            if let error = error {
                print("checkIsUserFollowing func \(error.localizedDescription)")
            }
            guard let isFollowed = snapshot?.exists else { return }
            completion(isFollowed)
        }
    }
}

