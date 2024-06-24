//
//  UserCollectionViewCell.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 28.05.2024.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier: String = "userProfilePostCell"
    
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .belgrad
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        backgroundColor = .yellow
        addSubview(cellImageView)
        
        cellImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
}
