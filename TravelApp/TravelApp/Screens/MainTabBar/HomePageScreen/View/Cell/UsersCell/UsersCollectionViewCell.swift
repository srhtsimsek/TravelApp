//
//  UsersCollectionViewCell.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 22.05.2024.
//

import UIKit

final class UsersCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "usersCell"
    
    var tappedButton: (() -> ())?
    var userItem: UsersCellModel?
    
    let containerView: UIView = {
        let view = UIView()
        return view
    }()
    let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = false
        imageView.backgroundColor = .yellow
//        imageView.frame.size = CGSize(width: 128, height: 128)
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = CGColor(gray: .greatestFiniteMagnitude, alpha: 1)
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = CustomLabel(title: "Name", font: .semibold, fontSize: .small)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    let cityLabel: UILabel = {
        let label = CustomLabel(title: "Name", font: .medium, fontSize: .xsmall)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        return label
    }()
    let nameCityStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        return stackview
    }()
    let lineView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 2))
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 1
        view.layer.masksToBounds = true
        return view
    }()
    
    let followButton: UIButton = {
        let button = CustomButton(title: "Takip Et", fontSize: .small, hasBackground: true)
//        button.setTitleColor(.systemBlue, for: .normal)
//        button.backgroundColor = .white.withAlphaComponent(0.7)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        buttonActions()
        configUI()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buttonActions() {
        followButton.addTarget(self, action: #selector(didTapFollowButtonCell), for: .touchUpInside)
    }
    
    @objc func didTapFollowButtonCell(_ sender: UIButton) {
        print("follow button tapped")
            followButton.setTitle("Takip Ediliyor", for: .normal)
        tappedButton?()
    }
    
    func configUI(){
        addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(nameCityStackView)
        nameCityStackView.addArrangedSubview(nameLabel)
        nameCityStackView.addArrangedSubview(cityLabel)
        containerView.addSubview(lineView)
        containerView.addSubview(followButton)
        
        containerView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        imageView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingRight: 5, widght: 100, height: 100)
        
        nameCityStackView.anchor(top: imageView.bottomAnchor, left: containerView.leftAnchor, bottom: lineView.topAnchor, right: containerView.rightAnchor, paddingTop: 8, paddingLeft: 3, paddingBottom: 5, paddingRight: 3)
        
        lineView.anchor(top: nameCityStackView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 3, paddingRight: 3, widght: 40, height: 2)
        
        followButton.anchor(top: lineView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 5, paddingBottom: 10, paddingRight: 5)
        
    }
    
    func setup(model: UsersCellModel ) {
        self.imageView.image = UIImage(named: "\(String(describing: model.image))")
        self.nameLabel.text = "\(model.name)"
        self.cityLabel.text = "\(model.city)"
    }
}
