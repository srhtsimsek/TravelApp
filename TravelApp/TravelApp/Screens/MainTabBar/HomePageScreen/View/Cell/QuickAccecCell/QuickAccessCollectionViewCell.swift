//
//  servicesButtonsCollectionViewCell.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 20.05.2024.
//

import UIKit

    //MARK: Protocol
protocol QuickAccessUpdateItemsProtocol {
    func updateServiceItems(image: String, buttonTitle: String)
}

//protocol CustomCellDelegate: AnyObject {
//    func didTapButton(in cell: ServicesButtonsCollectionViewCell)
//}

final class QuickAccessCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    static let reuseIdentifier = "serviceCell"
    
//    var servicesButtonTapped: (() -> ())?
    
    //MARK: View
    let containerView: UIView = {
        let view = UIView()
//        view.backgroundColor = .blue.withAlphaComponent(0.65)
        view.backgroundColor = .clear
        view.layer.cornerRadius = 8
//        view.layer.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
//        view.frame.size = CGSize(width: 60, height: 40)
        return view
    }()
//    let imageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        imageView.clipsToBounds = true
//        
//        imageView.backgroundColor = .clear
//        imageView.frame.size = CGSize(width: 64, height: 64)
//        return imageView
//    }()
    
    let serviceButton: UIButton = {
        let button = CustomButton(title: "", fontSize: .small, hasBackground: true)
        button.backgroundColor = .lightGray.withAlphaComponent(0.25)
        button.setTitleColor( .black.withAlphaComponent(0.85), for: .normal)
        button.setTitleColor( .black, for: .highlighted)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
//        button.frame.size = CGSize(width: 50, height: 20)
//        button.setTitle("error", for: .normal)
//        button.backgroundColor = .red
//        button.tintColor = .blueFromColorSet
//        
//        button.layer.cornerRadius = 10
//        button.layer.masksToBounds = true
//        button.clipsToBounds = true
        
        return button
    }()
    
    //MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: Actions
    @objc func didTapButtonCell() {
//        servicesButtonTapped?()
    }

    //MARK: Helpers
    func setup(model: QuickAccessCellModel) {
//        imageView.image = UIImage(named: "\(model.image)")
        serviceButton.setTitle("\(model.buttonName)", for: .normal)
    }
    //MARK: Config UI
    private func configure() {
//        self.layer.cornerRadius = 14
        backgroundColor = .clear
        addSubview(containerView)
//        containerView.addSubview(imageView)
        containerView.addSubview(serviceButton)
        
        containerView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
//        imageView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, paddingTop: 5, paddingLeft: 8, paddingBottom: 5, widght: 20, height: 20)
        
        serviceButton.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 5, paddingRight: 0)
        
////        serviceButton.frame.size = CGSize(width: 50, height: 20)
        serviceButton.addTarget(self, action: #selector(didTapButtonCell), for: .touchUpInside)
    }
}

//MARK: -Extension
extension QuickAccessCollectionViewCell: QuickAccessUpdateItemsProtocol {
    func updateServiceItems(image: String, buttonTitle: String) {
//        imageView.image = UIImage(named: "\(image)")
        serviceButton.setTitle(buttonTitle, for: .normal)
    }
}
