//
//  ProfileHeaderCollectionReusableView.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 28.05.2024.
//

import UIKit

protocol ProfileHeaderProtocol: AnyObject {
    func header(_ header: ProfileHeaderCollectionReusableView, viewModel: ProfileHeaderViewModel)
}

class ProfileHeaderCollectionReusableView: UICollectionReusableView {
    
    //MARK: Properties
    static let reuseIdentifier: String = "userHeaderID"
    weak var delegate: ProfileHeaderProtocol?
    var headerViewModel: ProfileHeaderViewModel? {
        didSet { configureUserData() }
    }
    
    //MARK: View
    let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 128, height: 128))
        imageView.image = .defaultPP
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = false
        imageView.backgroundColor = .yellow
//        imageView.frame.size = CGSize(width: 128, height: 128)
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = CGColor(red: 0.5, green: 0.3, blue: 0.8, alpha: 1)
        imageView.backgroundColor = .yellow
        return imageView
    }()
    
    let followStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.distribution = .fillEqually
        return stackview
    }()
    
    lazy var followersLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.attributedText = setAttributedText(value: 1, label: "followers")
        label.textAlignment = .center
        return label
    }()
    
    lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = setAttributedText(value: 2, label: "following")
        return label
    }()
    
    lazy var postLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = setAttributedText(value: 3, label: "post")
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = CustomLabel(title: "", font: .semibold, fontSize: .small)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    let cityLabel: UILabel = {
        let label = CustomLabel(title: "", font: .medium, fontSize: .small)
        label.textAlignment = .left
        label.textColor = .secondaryLabel
        return label
    }()
    
    let personalDataStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    let countVisitedCountryLabel: UILabel = {
        let label = CustomLabel(title: "visited count", font: .medium, fontSize: .small)
        label.textAlignment = .left
        label.textColor = .secondaryLabel
        return label
    }()
    let knownLanguagesLabel: UILabel = {
        let label = CustomLabel(title: "languages", font: .medium, fontSize: .small)
        label.textAlignment = .left
        label.textColor = .secondaryLabel
        return label
    }()
    
    let bioTextView: UITextView = {
        let tw = UITextView()
        tw.text = "bio"
        tw.textColor = .secondaryLabel
        tw.isEditable = false
        tw.backgroundColor = .clear
        tw.textAlignment = .left
        tw.isSelectable = false
        return tw
    }()
    
    @objc let editProfileButton: UIButton = {
        let button = CustomButton(title: "", fontSize: .small, hasBackground: true)
        button.backgroundColor = .secondaryLabel
        return button
    }()
    let showReviewsButton: UIButton = {
        let button = CustomButton(title: "Reviews", fontSize: .small, hasBackground: true)
        button.backgroundColor = .purple.withAlphaComponent(0.8)
        return button
    }()
    let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    //MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        configureUserData()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Helpers
    func setAttributedText(value: Int, label: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "\(value)\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: label, attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        
        return attributedText
    }

    func configureUserData() {
        guard let headerViewModel = headerViewModel else { return }
        print("viewModel configure func")
        nameLabel.text = headerViewModel.fullName
        let buttonTitle = headerViewModel.followButtonText
        editProfileButton.backgroundColor = headerViewModel.followButtonColor
        editProfileButton.setTitle(buttonTitle, for: .normal)
    }
    
    //MARK: Add Targets
    func addTargets() {
        editProfileButton.addTarget(self, action: #selector(editProfileButtonClicked), for: .touchUpInside)
    }
    //MARK: Buton Actions
    @objc func editProfileButtonClicked(_ sender: UIButton) {
        print("editProfileButtonClicked")
        guard let viewModel = headerViewModel else { return }
        delegate?.header(self, viewModel: viewModel)
    }
    //MARK: CongigUI
    func configUI() {
        containerView.backgroundColor = .white
        
        addSubview(containerView)
        containerView.addSubview(profileImageView)
        containerView.addSubview(followStackView)
        containerView.addSubview(personalDataStackView)
        
        followStackView.addArrangedSubview(followersLabel)
        followStackView.addArrangedSubview(followingLabel)
        followStackView.addArrangedSubview(postLabel)
        
        personalDataStackView.addArrangedSubview(nameLabel)
        personalDataStackView.addArrangedSubview(knownLanguagesLabel)
        personalDataStackView.addArrangedSubview(countVisitedCountryLabel)
        personalDataStackView.addArrangedSubview(cityLabel)
        
        containerView.addSubview(bioTextView)
        containerView.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(editProfileButton)
        buttonsStackView.addArrangedSubview(showReviewsButton)
        
        editProfileButton.anchor(widght: 150)
        showReviewsButton.anchor(widght: 150)
        
        
        containerView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        profileImageView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, paddingTop: 15, paddingLeft: 10, widght: 128, height: 128)
        
        followStackView.anchor(top: containerView.topAnchor, left: profileImageView.rightAnchor, right: containerView.rightAnchor, paddingTop: 15, paddingLeft: 0, paddingRight: 3)
        
        personalDataStackView.anchor(top: followStackView.bottomAnchor, left: profileImageView.rightAnchor, paddingTop: 10, paddingLeft: 10)
        
        bioTextView.anchor(top: profileImageView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 40, height: 40)
        
        buttonsStackView.anchor(top: bioTextView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 3, paddingLeft: 15, paddingRight: 15)
    }

}
