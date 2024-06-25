//
//  CompositionalLayoutManager.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 22.05.2024.
//

import UIKit

enum LayoutType {
    case horizontal
    case normal(headerIdentifier: String?)
    case users(headerIdentifier: String?)
}

final class CompositionalLayoutManager {
    private init() {}
    
    static let sharedInstance = CompositionalLayoutManager()

    func createLayoutSection(layoutType: LayoutType) -> NSCollectionLayoutSection {
        switch layoutType {
        case .horizontal:
            return createHorizontalSection()
        case .normal(let headerIdentifier):
            return createNormalSection(headerIdentifier: headerIdentifier)
        case .users(let headerIdentifier):
            return createUserSection(headerIdentifier: headerIdentifier)
        }
    }
    
    private func createHorizontalSection() -> NSCollectionLayoutSection {
        var itemSize: NSCollectionLayoutSize? = nil
        var groupSize: NSCollectionLayoutSize? = nil
        
        groupSize = NSCollectionLayoutSize(widthDimension: .absolute(180),
                                           heightDimension: .estimated(50))
        itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                          heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize!)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize!, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 0)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        return section
    }
    
    private func createNormalSection(headerIdentifier: String?) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85) , heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        if let headerIdentifier = headerIdentifier, headerIdentifier != "" {
            section.boundarySupplementaryItems = [
                .init(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            ]
        }
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 7, bottom: 25, trailing: 5)
        return section
    }
    
    private func createUserSection(headerIdentifier: String?) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.333) , heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        if let headerIdentifier = headerIdentifier, headerIdentifier != "" {
            section.boundarySupplementaryItems = [
                .init(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            ]
        }
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 7, bottom: 40, trailing: 5)
        return section
    }
}
