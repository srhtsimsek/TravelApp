//
//  ExploreLocationCollectionViewCell.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 22.05.2024.
//

import UIKit

final class ExploreLocationCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "exploreCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = false
        imageView.backgroundColor = .white
//        imageView.frame.size = CGSize(width: 120, height: 80)
        return imageView
    }()
    
    let visualEffectView: UIVisualEffectView = {
        let vEffect = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        vEffect.layer.cornerRadius = 10
        return vEffect
    }()
    let containerOfStackView: UIView = {
        let view = UIView()
        
        return view
    }()
    let visualStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        return stackview
    }()
    let titleLabel: UILabel = {
        let label = CustomLabel(title: "DestinationTitle", font: .bold, fontSize: .big)
        label.textAlignment = .left
        return label
    }()
    let subTitleLabel: UILabel = {
        let label = CustomLabel(title: "subTitle", font: .medium, fontSize: .small)
        
        return label
    }()
    let descriptionTextView: UITextView = {
        let tw = UITextView()
        tw.text = "ülke hakkında açıklama"
        tw.textColor = .secondaryLabel
        tw.isEditable = false
        tw.backgroundColor = .clear
        tw.textAlignment = .left
        tw.isSelectable = false
        return tw
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 80
        contentView.layer.masksToBounds = true
        
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(model: ExploreLocationCellModel) {
        imageView.image = UIImage(named: "\(model.image)")
        titleLabel.text = model.title
        subTitleLabel.text = model.subTitle
        descriptionTextView.text = model.description
    }
    
    func configUI() {
        addSubview(imageView)
//        addSubview(visualEffectView)
        imageView.addSubview(visualEffectView) //
        visualEffectView.contentView.addSubview(containerOfStackView)

        containerOfStackView.addSubview(visualStackView)
        visualStackView.addArrangedSubview(titleLabel)
        visualStackView.addArrangedSubview(subTitleLabel)
        visualStackView.addArrangedSubview(descriptionTextView)
        imageView.layer.cornerRadius = 13
        imageView.layer.masksToBounds = true
        
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, widght: self.frame.height, height: self.frame.width)

        visualEffectView.anchor(top: imageView.topAnchor, left: imageView.leftAnchor, bottom: imageView.bottomAnchor, right: imageView.rightAnchor, paddingTop: 120, paddingLeft: 0, paddingBottom: -3, paddingRight: 0)
        containerOfStackView.anchor(top: visualEffectView.topAnchor, left: visualEffectView.leftAnchor, bottom: visualEffectView.bottomAnchor, right: visualEffectView.rightAnchor, paddingTop: 3, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        visualStackView.anchor(top: containerOfStackView.topAnchor, left: containerOfStackView.leftAnchor, bottom: containerOfStackView.bottomAnchor, right: containerOfStackView.rightAnchor, paddingTop: 3, paddingLeft: 3, paddingBottom: 0, paddingRight: 0)
        
//        titleLabel.anchor(top: visualEffectView.topAnchor, left: visualEffectView.leftAnchor, paddingTop: 3, paddingLeft: 3)
//        
//        subTitleLabel.anchor(top: visualEffectView.topAnchor, left: titleLabel.rightAnchor, paddingTop: 3, paddingLeft: 3)
//        
//        descriptionTextView.anchor(top: titleLabel.topAnchor, left: visualEffectView.leftAnchor, bottom: visualEffectView.bottomAnchor, right: visualEffectView.rightAnchor, paddingTop: 5, paddingLeft: 3, paddingBottom: 3, paddingRight: 3)
    }
}
