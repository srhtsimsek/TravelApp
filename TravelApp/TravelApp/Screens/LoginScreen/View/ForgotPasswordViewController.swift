//
//  ForgotPasswordViewController.swift
//  notriphoiba
//
//  Created by Serhat  Şimşek  on 10.05.2024.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    //MARK: Properties
    private var viewModel = ForgotPasswordViewModel()
    //MARK: View
    private lazy var forgotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(resource: .forgotPassword1)
        return imageView
    }()
    
    private lazy var titleLabel = CustomLabel(title: "Reset Password", font: .semibold, fontSize: .big)
    private lazy var descriptionLabel = CustomLabel(title: " I forgot my password", font: .regular, fontSize: .medium)
    private lazy var emailTextField = CustomTextField(customfieldType: .email)
    private lazy var forgotButton = CustomButton(title: "Reset", fontSize: .big, hasBackground: true)
    
    private lazy var headStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.backgroundColor = .white
        return stackView
    }()
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = -30
        stackView.backgroundColor = .white
        return stackView
    }()
    private lazy var resetUIElementsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 30
        stackView.backgroundColor = .white
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureNotificationObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: Helpers
    private func configureNotificationObservers(){
        forgotButton.isEnabled = false
        forgotButton.backgroundColor = .systemBlue.withAlphaComponent(0.50)
        
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .allEditingEvents)
    }
    
    private func addTarget(){
        forgotButton.addTarget(self, action: #selector(clickedForgotButton), for: .touchUpInside)
    }
    //MARK: #selector
    @objc private func clickedForgotButton() {
        
    }
    @objc func textDidChange(sender: UITextField) {
        viewModel.email = emailTextField.text
        
        formUpdate()
    }
    //MARK: Config UI
    
    private func setupUI(){
        view.backgroundColor = .white
        addUIViews()
        configStackViews()
        configUIElements()
    }
    private func addUIViews(){
        view.addSubViewsFromExtension(headStackView, resetUIElementsStackView)
    }
    private func configStackViews() {
        configHeadStackView()
        configResetUIElementsStackView()
        configImageview()
        
    }
    private func configHeadStackView() {
        headStackView.addArrangedSubview(forgotImageView)
        headStackView.addArrangedSubview(labelStackView)
        
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(descriptionLabel)
        
        headStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 40, paddingRight: 40, height:450)
        
    }
    private func configResetUIElementsStackView() {
        resetUIElementsStackView.addArrangedSubview(emailTextField)
        resetUIElementsStackView.addArrangedSubview(forgotButton)
        
        resetUIElementsStackView.anchor(top: headStackView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 30, paddingRight: 30)
    }
    private func configUIElements() {
        
        configTextField()
        configResetButton()
    }
    private func configImageview(){
        forgotImageView.layer.masksToBounds = false
        forgotImageView.clipsToBounds = true
        forgotImageView.layer.borderWidth = 2.0
        forgotImageView.layer.borderColor = CGColor(red: 0.20, green: 0.47, blue: 1.00, alpha: 1.00)
        forgotImageView.frame.size = CGSize(width: 256, height: 256)
        forgotImageView.layer.cornerRadius = forgotImageView.frame.height / 2
        
        forgotImageView.anchor(top: headStackView.topAnchor, left: headStackView.leftAnchor, bottom: headStackView.bottomAnchor, right: headStackView.rightAnchor, paddingTop: 50, paddingLeft: 20, paddingBottom: 120, paddingRight: 20)
        
    }
    private func configTextField() {
        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: emailTextField.frame.size.height))
        
        emailTextField.anchor(top: resetUIElementsStackView.topAnchor, left: resetUIElementsStackView.leftAnchor, right: resetUIElementsStackView.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 10, height: 55)
    }
    private func configResetButton() {
        forgotButton.anchor(top: emailTextField.bottomAnchor, left: resetUIElementsStackView.leftAnchor, right: resetUIElementsStackView.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20, height: 55)
    }
}

//MARK: - Extension
extension ForgotPasswordViewController: FormViewModel {
    func formUpdate() {
        forgotButton.backgroundColor = viewModel.buttonBackgroundColor
        forgotButton.isEnabled = viewModel.formIsValid
    }
}
