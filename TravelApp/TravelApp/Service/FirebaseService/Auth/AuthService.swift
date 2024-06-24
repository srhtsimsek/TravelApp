//
//  AuthService.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 17.05.2024.
//

import FirebaseAuth
import FirebaseFirestore

/// A typealias for Firebase completion handler closures.
typealias FirebaseCompletionHandler = (Error?) -> Void

struct AuthService {
    public static let shared = AuthService()
    
    private init() {}
    
    //MARK: Register User
    /// A method to register the user
    /// - Parameters:
    ///   - userRequest: The users information (fullname, username, mail, password)
    ///   - copletion: Has two values (Bool, Error)
    ///   - Bool: Determines if the user was registered and saved to Firebase correctly
    ///   - Error?: An optional error
    public func registerUser(userRequest: RegisterUserModel, completion:@escaping (Bool, Error?) -> Void) {
        let fullName = userRequest.fullName
        let username = userRequest.username
        let email = userRequest.email
        let password = userRequest.password
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(false, error)
                return
            }
            
            guard let userUid = result?.user.uid else {
                completion(false, nil)
                return
            }
            
            let userData: [String: Any] = ["uid": userUid,
                                           "fullName": fullName,
                                           "username": username,
                                           "email": email]
            
            COLLECTION_USERS
                .document(userUid)
                .setData(userData) { error in
                    if let error = error {
                        completion(false, error)
                        return
                    }
                    completion(true, nil)
                }
        }
    }
    
    //MARK: User sign In
    /// Authenticates and signs in the user with provided credentials.
    /// - Parameters:
    ///   - userRequest: User's login information (email, password).
    ///   - completion: Closure with optional Error parameter. Nil if sign-in is successful, otherwise contains the encountered error.
    public func signInUser(userRequest: LogInUserModel, completion: @escaping(FirebaseCompletionHandler)) {
        Auth.auth().signIn(withEmail: userRequest.email, password: userRequest.password) { result, error in
            if let error = error {
                completion(error)
                return
            } else {
                completion(nil)
            }
        }
    }
    
    //MARK: User sign Out
    public func signOutUser(completion: @escaping(FirebaseCompletionHandler)) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
}
