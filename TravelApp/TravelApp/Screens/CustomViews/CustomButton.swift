//
//  CustomButton.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 8.05.2024.
//

import UIKit

class CustomButton: UIButton {
    enum FontSize {
        case small
        case medium
        case big
    }
    
    init(title: String, fontSize: FontSize, hasBackground: Bool = false){
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 12
        
        self.backgroundColor = hasBackground ? .systemBlue : .clear
        
        let titleColor: UIColor = hasBackground ? .white : .systemBlue
        self.setTitleColor(titleColor, for: .normal)
        
        switch fontSize {
        case .big:
            self.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
            
        case .medium:
            self.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
            
        case .small:
            self.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
