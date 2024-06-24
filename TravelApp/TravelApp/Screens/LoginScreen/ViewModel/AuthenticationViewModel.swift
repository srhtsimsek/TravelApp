//
//  LoginViewModel.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 25.05.2024.
//

import UIKit

//MARK:  - Protocol

protocol AuthSignInViewModelDelegate: AnyObject {
    func didSignInSuccess()
    func didSignInFail(with error: Error)
}

protocol FormViewModel {
    func formUpdate()
}

protocol AuthenticationViewModelProtocol {
    /// Control the text fields. If they are not empty, the login button is activated.
    var formIsValid: Bool { get }
    var buttonBackgroundColor: UIColor { get }
}

//MARK: - SignInViewModel
struct SignInViewModel: AuthenticationViewModelProtocol {
    
    weak var delegate: AuthSignInViewModelDelegate?
    
    var email: String?
    var password: String?

    var formIsValid: Bool {
        return  email?.isEmpty == false && password?.isEmpty == false
    }
    var buttonBackgroundColor: UIColor {
        return formIsValid ? .systemBlue : .systemBlue.withAlphaComponent(0.50)
    }
    
    func signIn(email: String, password: String) {
        let user = LogInUserModel(email: email, password: password)
        AuthService.shared.signInUser(userRequest: user) { error in
            if let error = error {
                delegate?.didSignInFail(with: error)
                return
            }
            delegate?.didSignInSuccess()
        }
    }
}

//MARK: - SignUpViewModel
struct SigUpViewModel: AuthenticationViewModelProtocol {
    var fullName: String?
    var userName: String?
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return  fullName?.isEmpty == false &&
                userName?.isEmpty == false &&
                email?.isEmpty == false &&
                password?.isEmpty == false
    }
    var buttonBackgroundColor: UIColor {
        return formIsValid ? .systemBlue : .systemBlue.withAlphaComponent(0.50)
    }
}

//MARK: - ForgotPasswordViewModel
struct ForgotPasswordViewModel: AuthenticationViewModelProtocol {
    var email: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
    }
    var buttonBackgroundColor: UIColor {
        formIsValid ? .systemBlue : .systemBlue.withAlphaComponent(0.50)
    }
}
