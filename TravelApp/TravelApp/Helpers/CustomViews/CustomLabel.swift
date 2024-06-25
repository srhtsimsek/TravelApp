//
//  CustomLabel.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 8.05.2024.
//

import UIKit

class CustomLabel: UILabel {
    
    enum FontSize {
        /// big  = ofSize: 24
        case big
        /// medium= ofSize: 18
        case medium
        /// small = ofSize: 13
        case small
        /// small = ofSize: 11
        case xsmall
    }
    
    init(title: String, font: UIFont.Weight ,fontSize: FontSize) {
        super.init(frame: .zero)
        
        self.text = title
        
        switch fontSize {
        case .big:
            self.font = .systemFont(ofSize: 24, weight: font)
        case .medium:
            self.font = .systemFont(ofSize: 18, weight: font)
        case .small:
            self.font = .systemFont(ofSize: 13, weight: font)
        case .xsmall:
            self.font = .systemFont(ofSize: 11, weight: font)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
