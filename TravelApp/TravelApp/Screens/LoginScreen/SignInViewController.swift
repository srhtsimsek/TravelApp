//
//  SignUpLoginController.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 6.05.2024.
//

import UIKit

class SignInViewController: UIViewController {
    
    //MARK: View
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.image = .logo
        return imageView
    }()
    
    private lazy var titleLabel = CustomLabel(title: "Sign In", font: .semibold, fontSize: .big)
    private lazy var descriptionLabel = CustomLabel(title: "are you ready for an adventure?", font: .regular, fontSize: .medium)
    
    private lazy var emailTextField = CustomTextField(customfieldType: .email)
    private lazy var passwordTextField = CustomTextField(customfieldType: .password)
    
    private lazy var signInButton = CustomButton(title: "Sign In", fontSize: .big, hasBackground: true)
    private lazy var newUserButton = CustomButton(title: "New User? Create Account", fontSize: .medium)
    private lazy var forgotPasswordButton = CustomButton(title: "I Forgot My Password", fontSize: .small)
    
    private lazy var headStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.backgroundColor = .white
        return stackView
    }()
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.backgroundColor = .white
        return stackView
    }()
    private lazy var loginTextFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 30
        return stackView
    }()
    private lazy var loginButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addTarget()
        print("s")
    }
    
    //MARK: Add Target
    private func addTarget(){
        signInButton.addTarget(self, action: #selector(clickedSignInButton), for: .touchUpInside)
        newUserButton.addTarget(self, action: #selector(clickedNewUserButton), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(clickedForgotPasswordButton), for: .touchUpInside)
    }
    
    //MARK: #selector
    @objc private func clickedSignInButton() {
        print("clicked sign in button")
    }
    @objc private func clickedNewUserButton() {
        print("clicked new user button")
        let vc = SignUpViewController()
        self.present(vc, animated: true)
    }
    @objc private func clickedForgotPasswordButton() {
        print("clicked forgot button")
        let vc = ForgotPasswordViewController()
        self.present(vc, animated: true)
    }
    
    //MARK: Config UI
    private func setupUI(){
        view.backgroundColor = .white
        addUIViews()
        configStackViews()
        configLoginUIElements()
    }
    
    private func addUIViews(){
        view.addSubViewsFromExtension(headStackView, loginTextFieldsStackView, loginButtonsStackView)
    }
    
    private func configHeadStackView() {
        headStackView.addArrangedSubview(logoImageView)
        headStackView.addArrangedSubview(labelStackView)
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(descriptionLabel)
    }
    
    private func configLogInTextFieldsStackView() {
        loginTextFieldsStackView.addArrangedSubview(emailTextField)
        loginTextFieldsStackView.addArrangedSubview(passwordTextField)
        loginTextFieldsStackView.addArrangedSubview(signInButton)
        loginTextFieldsStackView.addArrangedSubview(newUserButton)
        loginTextFieldsStackView.addArrangedSubview(forgotPasswordButton)
    }
    
    private func configLogInButtonStackView() {
        loginButtonsStackView.addArrangedSubview(signInButton)
        loginButtonsStackView.addArrangedSubview(newUserButton)
        loginButtonsStackView.addArrangedSubview(forgotPasswordButton)
    }
    
    private func configStackViews(){
        configHeadStackView()
        configLogInTextFieldsStackView()
        configLogInButtonStackView()
        
        headStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 60, paddingLeft: 40, paddingRight: 40)
        loginTextFieldsStackView.anchor(top: headStackView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 30, paddingRight: 30)
        loginButtonsStackView.anchor(top: loginTextFieldsStackView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 30, paddingRight: 30 )
    }
    
    private func configLoginUIElements() {
        configTextFields()
        configLoginButton()
        configImageview()
    }
    
    private func configImageview(){
        logoImageView.layer.masksToBounds = false
        logoImageView.clipsToBounds = true
        logoImageView.layer.borderWidth = 2.0
        logoImageView.layer.borderColor = CGColor(red: 0.20, green: 0.47, blue: 1.00, alpha: 1.00)
        logoImageView.frame.size = CGSize(width: 256, height: 256)
        logoImageView.layer.cornerRadius = logoImageView.frame.height / 2
    }
    
    private func configTextFields() {
        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: emailTextField.frame.size.height))
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: emailTextField.frame.size.height))
        emailTextField.anchor(top: loginTextFieldsStackView.topAnchor, left: loginTextFieldsStackView.leftAnchor, right: loginTextFieldsStackView.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 10, height: 55)
        passwordTextField.anchor(top: emailTextField.bottomAnchor, left: loginTextFieldsStackView.leftAnchor, right: loginTextFieldsStackView.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingRight: 10, height: 55)
    }
    
    private func configLoginButton() {
        signInButton.adjustsImageWhenHighlighted = true
        signInButton.anchor(top: passwordTextField.bottomAnchor, left: loginTextFieldsStackView.leftAnchor, right: loginTextFieldsStackView.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20, height: 55)
    }
}
