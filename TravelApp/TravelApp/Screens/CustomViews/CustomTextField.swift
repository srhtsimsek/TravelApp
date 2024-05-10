//
//  CustomTextField.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 7.05.2024.
//

import UIKit

class CustomTextField: UITextField {

    enum CustomKeyboardType {
        case username
        case email
        case password
    }
    
    private let customfieldType: CustomKeyboardType
    
    init(customfieldType: CustomKeyboardType) {
        self.customfieldType = customfieldType
        super.init(frame: .zero)
        
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 10
        
        self.returnKeyType = .done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        
        self.leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.size.height))
        
        switch customfieldType {
        case .username:
            self.placeholder = "Username"
        case .email:
            self.placeholder = "Email Address"
            self.keyboardType = .emailAddress
            self.textContentType = .emailAddress
            
        case .password:
            self.placeholder = "Password"
            self.textContentType = .oneTimeCode
            self.isSecureTextEntry = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
