//
//  SignUpLoginController.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 6.05.2024.
//

import UIKit

class SignInViewController: UIViewController {
    
    //MARK: Properties
    private var viewModel = SignInViewModel()
    //MARK: View
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.image = .logo
        return imageView
    }()
    
    private let titleLabel = CustomLabel(title: "Sign In", font: .semibold, fontSize: .big)
    private let descriptionLabel = CustomLabel(title: "are you ready for an adventure?", font: .regular, fontSize: .medium)
    
    private let emailTextField = CustomTextField(customfieldType: .email)
    private let passwordTextField = CustomTextField(customfieldType: .password)
    
    private let signInButton = CustomButton(title: "Sign In", fontSize: .big, hasBackground: true)
    private let newUserButton = CustomButton(title: "New User? Create Account", fontSize: .medium)
    private let forgotPasswordButton = CustomButton(title: "I Forgot My Password", fontSize: .small)
    
    private let headStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.backgroundColor = .white
        return stackView
    }()
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.backgroundColor = .white
        return stackView
    }()
    private let loginTextFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 30
        return stackView
    }()
    private let loginButtonsStackView: UIStackView = {
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
        viewModel.delegate = self
        configureNotificationObservers()
        addTarget()
    }
    
    //MARK: Helpers
    private func configureNotificationObservers() {
        signInButton.isEnabled = false
        signInButton.backgroundColor = .systemBlue.withAlphaComponent(0.50)
        
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .allEditingEvents)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .allEditingEvents)
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
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        viewModel.signIn(email: email, password: password)
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
    
    @objc func textDidChange(sender: UITextField) {
        viewModel.email = emailTextField.text
        viewModel.password = passwordTextField.text
        formUpdate()
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

//MARK: - Extension
extension SignInViewController: FormViewModel {
    func formUpdate() {
        signInButton.backgroundColor = viewModel.buttonBackgroundColor
        signInButton.isEnabled = viewModel.formIsValid
    }
}

extension SignInViewController: AuthSignInViewModelDelegate {
    func didSignInSuccess() {
        let mainVC = TabBarController()
        mainVC.modalPresentationStyle = .fullScreen
        mainVC.modalTransitionStyle = .flipHorizontal
        self.present(mainVC, animated: true)
    }
    
    func didSignInFail(with error: any Error) {
        UIAlertController.showSignInErrorAlert(on: self, error: error)
    }
}
