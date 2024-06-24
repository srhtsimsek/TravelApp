//
//  SearchTableViewCell.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 2.06.2024.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    var viewModel: CellViewModel? {
        didSet {
            configureCellData()
        }
    }
    
    //MARK: View
    let profileImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 48, height: 48))
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = .defaultPP
        return imageView
    }()
    let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 3
        return stackView
    }()
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "serhatsimsek"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    var fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Serhat Şimşek"
        label.font = .systemFont(ofSize: 11, weight: .medium)
        label.textColor = .lightGray
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Helpers
    func configureCellData() {
        guard let viewModel = viewModel else { return }
        usernameLabel.text = viewModel.username
        fullNameLabel.text = viewModel.fullName
    }
    
    //MARK: Configure UI
    private func configureUI() {
        
        addSubview(profileImageView)
        addSubview(labelStackView)
        labelStackView.addArrangedSubview(usernameLabel)
        labelStackView.addArrangedSubview(fullNameLabel)
        
        profileImageView.centerY(in: self, left: self.leftAnchor, paddingLeft: 10)
        profileImageView.setDimensions(height: 48, width: 48)
        
        labelStackView.centerY(in: self, left: profileImageView.rightAnchor, paddingLeft: 10)
    }
}
