//
//  ExploreLocationHeaderView.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 23.05.2024.
//

import UIKit

class ExploreLocationHeaderView: UICollectionReusableView {
    //MARK: Properties
    static let headerIdentifier = "ExploreLocationHeaderView"
    
    //MARK: View
    let backgroundView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 25))
        view.layer.cornerRadius = 1
        view.layer.masksToBounds = true
        return view
    }()
    let titleLeftView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 2, height: 10))
        view.backgroundColor = .orange
        view.layer.cornerRadius = 1
        view.layer.masksToBounds = true
        return view
    }()
    private let titleOfExploreHeader: UILabel = {
        let lbl = UILabel()
        lbl.text = "Lokasyonları Keşfet"
        lbl.font = .systemFont(ofSize: 20, weight: .bold)
        lbl.textAlignment = .left
        lbl.textColor = .black.withAlphaComponent(0.80)
        return lbl
    }()
    let seeAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("Tümünü Gör", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .gray.withAlphaComponent(0.10)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = false
        return button
    }()
    
    //MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Helpers
    //MARK: Target
    private func addTarget() {
        seeAllButton.addTarget(self, action: #selector(seeAllUsersButtonClicked), for: .touchUpInside)
    }
    //MARK: Selector
    @objc func seeAllUsersButtonClicked() {
        print("slm")
    }
    
    //MARK: Configure UI
    func configUI() {
        self.addSubViewsFromExtension(backgroundView, titleLeftView, titleOfExploreHeader, seeAllButton)
        backgroundView.backgroundColor = .white
        
        backgroundView.anchor(top: topAnchor, left:  leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        titleLeftView.anchor(top: backgroundView.topAnchor, left: backgroundView.leftAnchor, paddingTop: 9, paddingLeft: 0, widght: 2, height: 25)
        
        titleOfExploreHeader.anchor(top: backgroundView.topAnchor, left: titleLeftView.rightAnchor, right: backgroundView.rightAnchor, paddingTop: 9, paddingLeft: 3, paddingRight: 50)
        
        seeAllButton.anchor(top: backgroundView.topAnchor, left: titleOfExploreHeader.rightAnchor, bottom: backgroundView.bottomAnchor, paddingTop: 4, paddingLeft: -60, paddingBottom: 5, paddingRight: 2, widght: 110)
        
    }
    
}
