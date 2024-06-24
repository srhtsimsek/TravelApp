//
//  HomePageModel.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 22.05.2024.
//

import Foundation

    //MARK: Enum
enum HomePageCellType {
    case quickAccessCell
    case exploreLocationCell
    case usersCell
}

    //MARK: Protocol
protocol SectionModel {
    var sectionTitle: String? { get }
    var itemCount: Int { get }
    var cellType: HomePageCellType {get}
    
    func getItem(at index: Int) -> Any
}

    //MARK: - QuickAccessSection
struct QuickAccessSection: SectionModel {
    var sectionTitle: String?
    
    var quickAccessSectionList: [QuickAccessCellModel]
    
    var itemCount: Int {
        return quickAccessSectionList.count
    }
    
    var cellType: HomePageCellType {
        return .quickAccessCell
    }
    
    func getItem(at index: Int) -> Any {
        quickAccessSectionList[index]
    }
}

    //MARK: - ExploreLocationSection
struct ExploreLocationSection: SectionModel {
    var sectionTitle: String?
    
    var exploreLocationSectionList: [ExploreLocationCellModel]
    
    var itemCount: Int {
        return exploreLocationSectionList.count
    }
    
    var cellType: HomePageCellType {
        return .exploreLocationCell
    }
    
    func getItem(at index: Int) -> Any {
        exploreLocationSectionList[index]
    }
}

    //MARK: - UserSection
struct UserSection: SectionModel {
    var sectionTitle: String?
    
    var userSectionList: [UsersCellModel]

    var itemCount: Int {
        return userSectionList.count
    }
    
    var cellType: HomePageCellType {
        return .usersCell
    }
    
    func getItem(at index: Int) -> Any {
        userSectionList[index]
    }
}
