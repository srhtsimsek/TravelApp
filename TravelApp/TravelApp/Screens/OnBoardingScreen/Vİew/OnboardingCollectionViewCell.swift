//
//  OnboardingCollectionViewCell.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 28.04.2024.
//

import UIKit

final class OnboardingCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "SlideCell"
    
    lazy var cellImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleToFill
//        imageview.backgroundColor = .yellow
        return imageview
    }()
    lazy var headLineLabel: UILabel = {
        let label = UILabel()
//        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .lightFromColorSet
        return label
    }()
    lazy var subLineLabel: UILabel = {
        let label = UILabel()
//        label.textAlignment = .left
        label.numberOfLines = 3
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .lightFromColorSet
        return label
    }()
    lazy var descriptionStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func update(image: UIImage, headline: String, subheadline: String) {
        cellImageView.image = image
        headLineLabel.text = headline
        subLineLabel.text = subheadline
    }
    private func configure(){
        backgroundColor = .blueFromColorSet
        addSubViewsFromExtension(cellImageView, descriptionStackView)
        descriptionStackView.addArrangedSubview(headLineLabel)
        descriptionStackView.addArrangedSubview(subLineLabel)
        cellImageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 140, paddingLeft: 30, paddingRight: 30,widght: 400, height: 400)
        descriptionStackView.anchor(top: cellImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 60, paddingLeft: 30, paddingRight: 30)
    }
}
