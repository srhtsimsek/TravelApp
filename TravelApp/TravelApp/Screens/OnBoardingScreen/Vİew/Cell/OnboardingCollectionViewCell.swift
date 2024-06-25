//
//  OnboardingCollectionViewCell.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 28.04.2024.
//

import UIKit

protocol OnboardingViewUpdateItemsProtocol {
    func updateItems(image: UIImage, headline: String, subheadline: String)
}

final class OnboardingCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    static let reuseIdentifier = "SlideCell"
    
    lazy var cellImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    lazy var headLineLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        return label
    }()
    lazy var subLineLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white.withAlphaComponent(0.85)
        return label
    }()
    lazy var descriptionStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
    //MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Config UI
    private func configure(){
        backgroundColor = .blueFromColorSet
        addSubViewsFromExtension(cellImageView, descriptionStackView)
        descriptionStackView.addArrangedSubview(headLineLabel)
        descriptionStackView.addArrangedSubview(subLineLabel)
        cellImageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 140, paddingLeft: 30, paddingRight: 30,widght: 400, height: 400)
        descriptionStackView.anchor(top: cellImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 60, paddingLeft: 30, paddingRight: 30)
    }
}

    //MARK: Extension
extension OnboardingCollectionViewCell: OnboardingViewUpdateItemsProtocol {
    func updateItems(image: UIImage, headline: String, subheadline: String) {
        cellImageView.image = image
        headLineLabel.text = headline
        subLineLabel.text = subheadline
    }
}
