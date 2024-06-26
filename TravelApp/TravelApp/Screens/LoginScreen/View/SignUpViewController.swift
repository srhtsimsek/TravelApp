//
//  UserRegisterViewController.swift
//  notriphoiba
//
//  Created by Serhat  Şimşek  on 10.05.2024.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    //MARK: Properties
    private var viewModel = SigUpViewModel()
    
    //MARK: View
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.image = .logo
        return imageView
    }()
    
    private lazy var titleLabel = CustomLabel(title: "Sign Up", font: .semibold, fontSize: .big)
    private lazy var descriptionLabel = CustomLabel(title: "let's get started", font: .regular, fontSize: .medium)
    
    private lazy var fullNameTextField = CustomTextField(customfieldType: .fullname)
    private lazy var userNameTextField = CustomTextField(customfieldType: .username)
    private lazy var emailTextField = CustomTextField(customfieldType: .email)
    private lazy var passwordTextField = CustomTextField(customfieldType: .password)
    
    private lazy var signUpButton = CustomButton(title: "Sign Up", fontSize: .big, hasBackground: true)
    
    private lazy var termsTextView: UITextView = {
        let attributedString = NSMutableAttributedString(string: "Kullanım Şartlarını ve Gizlilik Politikasını kabul ediyorum")
        attributedString.addAttribute(.link, value: "terms://termsAndConditions", range: (attributedString.string as NSString).range(of: "Kullanım Şartlarını"))
        attributedString.addAttribute(.link, value: "privacy://privacyPolicy", range: (attributedString.string as NSString).range(of: "Gizlilik Politikasını"))
        
        let textView = UITextView()
        textView.attributedText = attributedString
        textView.linkTextAttributes = [.foregroundColor: UIColor.systemBlue]
        textView.backgroundColor = .clear
        textView.textAlignment = .center
        textView.textColor = .label
        textView.isSelectable = true
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    private lazy var headStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.backgroundColor = .white
        return stackView
    }()
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = -25
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
        stackView.spacing = 20
        return stackView
    }()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTextViewDelegate()
        configureNotificationObservers()
        addTarget()
    }
    
    //MARK: Delegate
    private func setupTextViewDelegate() {
        termsTextView.delegate = self
    }
    
    //MARK: Helpers
    private func configureNotificationObservers(){
        signUpButton.isEnabled = false
        signUpButton.backgroundColor = .systemBlue.withAlphaComponent(0.50)
        
        fullNameTextField.addTarget(self, action: #selector(textDidChange), for: .allEditingEvents)
        userNameTextField.addTarget(self, action: #selector(textDidChange), for: .allEditingEvents)
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .allEditingEvents)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .allEditingEvents)
    }
    private func clearTextFieldData() {
        fullNameTextField.text = ""
        userNameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    //MARK: Add Target
    private func addTarget(){
        signUpButton.addTarget(self, action: #selector(clickedSignUpButton), for: .touchUpInside)
    }
    
    //MARK: #selector
    @objc private func clickedSignUpButton() {
        print("clicked sign up button")
        guard let fullName = fullNameTextField.text else { return }
        guard let username = userNameTextField.text?.lowercased() else { return }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        let registerUser = RegisterUserModel(fullName: fullName,
                                                    username: username,
                                                    email: email,
                                                    password: password)
        
        AuthService.shared.registerUser(userRequest: registerUser) { bool, error in
            if let error = error {
                UIAlertController.showRegistrationErrorAlert(on: self, error: error)
            }
            if bool {
                self.clearTextFieldData()
                self.dismiss(animated: true)
            }
        }
    }
    
    @objc func textDidChange(sender: UITextField) {
        viewModel.fullName = fullNameTextField.text
        viewModel.userName = userNameTextField.text
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
        loginTextFieldsStackView.addArrangedSubview(fullNameTextField)
        loginTextFieldsStackView.addArrangedSubview(userNameTextField)
        loginTextFieldsStackView.addArrangedSubview(emailTextField)
        loginTextFieldsStackView.addArrangedSubview(passwordTextField)
        loginTextFieldsStackView.addArrangedSubview(signUpButton)
    }
    
    private func configLogInElementsStackView() {
        loginButtonsStackView.addArrangedSubview(signUpButton)
        loginButtonsStackView.addArrangedSubview(termsTextView)
    }
    
    private func configStackViews(){
        configHeadStackView()
        configLogInTextFieldsStackView()
        titleLabel.anchor(height: 25)
        descriptionLabel.anchor(height: 25)
        configLogInElementsStackView()
        
        headStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 40, paddingRight: 40)
        labelStackView.anchor(top: logoImageView.bottomAnchor, left: headStackView.leftAnchor, right: headStackView.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingRight: 0)
        loginTextFieldsStackView.anchor(top: headStackView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 30, paddingRight: 30)
        loginButtonsStackView.anchor(top: loginTextFieldsStackView.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 30, paddingBottom: 0, paddingRight: 30 )
    }
    
    private func configLoginUIElements() {
        configTextFields()
        configLoginButton()
        configImageview()
    }
    
    private func configImageview() {
        logoImageView.layer.masksToBounds = false
        logoImageView.clipsToBounds = true
        logoImageView.layer.borderWidth = 2.0
        logoImageView.layer.borderColor = CGColor(red: 0.20, green: 0.93, blue: 0.56, alpha: 1.00)
        logoImageView.anchor(widght: 100, height: 100)
        logoImageView.frame.size = CGSize(width: 100, height: 100)
        logoImageView.layer.cornerRadius = logoImageView.frame.height / 2
    }
    
    private func configTextFields() {
//        userNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: userNameTextField.frame.size.height))
//        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: userNameTextField.frame.size.height))
//        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: userNameTextField.frame.size.height))
//        
        fullNameTextField.clearButtonMode = .whileEditing
        userNameTextField.clearButtonMode = .whileEditing
        emailTextField.clearButtonMode = .whileEditing
        passwordTextField.clearButtonMode = .whileEditing
        
        fullNameTextField.anchor(top: loginTextFieldsStackView.topAnchor, left: loginTextFieldsStackView.leftAnchor, right: loginTextFieldsStackView.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 10, height: 55)
        userNameTextField.anchor(top: fullNameTextField.bottomAnchor, left: loginTextFieldsStackView.leftAnchor, right: loginTextFieldsStackView.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingRight: 10, height: 55)
        emailTextField.anchor(top: userNameTextField.bottomAnchor, left: loginTextFieldsStackView.leftAnchor, right: loginTextFieldsStackView.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingRight: 10, height: 55)
        passwordTextField.anchor(top: emailTextField.bottomAnchor, left: loginTextFieldsStackView.leftAnchor, right: loginTextFieldsStackView.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingRight: 10, height: 55)
    }
    
    private func configLoginButton() {
        signUpButton.anchor(top: loginButtonsStackView.topAnchor, left: loginButtonsStackView.leftAnchor, right: loginButtonsStackView.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingRight: 20, height: 55)
        
        termsTextView.anchor(top: signUpButton.bottomAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingTop: 5, paddingBottom: 130, height: 20)
        
    }
    
    private func changeAttributedTextColor() {
        termsTextView.linkTextAttributes = [.foregroundColor: UIColor.systemGreen]
        
    }
}

//MARK: -Extension
    //MARK: TextViewDelegate Extension
extension SignUpViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.scheme == "terms" {
            showWebViewerController(with: "https://policies.google.com/terms?hl=tr")
            changeAttributedTextColor()
        } else if URL.scheme == "privacy" {
            showWebViewerController(with: "https://policies.google.com/privacy?hl=tr")
            changeAttributedTextColor()
        }
        
        return true
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        textView.delegate = nil
        textView.selectedTextRange = nil
        textView.delegate = self
    }
    
    private func showWebViewerController(with urlString: String) {
        let vc = TermsAndConditionsViewController(url: urlString)
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
}

    //MARK: FormViewModel Extension
extension SignUpViewController: FormViewModel {
    func formUpdate() {
        signUpButton.backgroundColor = viewModel.buttonBackgroundColor
        signUpButton.isEnabled = viewModel.formIsValid
    }
}
