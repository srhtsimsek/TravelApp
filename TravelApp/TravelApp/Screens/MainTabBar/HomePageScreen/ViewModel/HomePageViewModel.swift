//
//  HomePageViewModel.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 22.05.2024.
//

import Foundation

final class HomePageViewModel {
    private var sectionList: [SectionModel] = []
    
    init() {
        generateQuickAccessSection()
        generateExploreLocationSection()
        generateUsersSection()
    }
}

extension HomePageViewModel {
    func generateQuickAccessSection() {
        let quickAccesSectionList: [QuickAccessCellModel] = [
            QuickAccessCellModel(image: "event", buttonName: "Events"),
            QuickAccessCellModel(image: "hotel", buttonName: "Hotels"),
            QuickAccessCellModel(image: "weather", buttonName: "Weather"),
            QuickAccessCellModel(image: "music", buttonName: "Maps"),
            QuickAccessCellModel(image: "music", buttonName: "Button5"),
            QuickAccessCellModel(image: "music", buttonName: "Button6")
        ]
        sectionList.append(QuickAccessSection(quickAccessSectionList: quickAccesSectionList))
    }
    
    func generateExploreLocationSection() {
        let exproleLocationList: [ExploreLocationCellModel] = [
            ExploreLocationCellModel(image: "istanbul", title: "İstanbul", subTitle: "Türkiye", description: "eşşiz şehre göz at."),
            ExploreLocationCellModel(image: "sanliurfa", title: "Urfa", subTitle: "Türkiye", description: "Tarihin sıfır noktası"),
            ExploreLocationCellModel(image: "elazig", title: "Elazığ", subTitle: "Türkiye", description: "firat üni var."),
            ExploreLocationCellModel(image: "tiflis", title: "Tiflis", subTitle: "Gürcistan", description: "güzel dokulu şehir."),
            ExploreLocationCellModel(image: "belgrad", title: "Belgrad", subTitle: "Sırbistan", description: "avrupaya açılan kapı.")
        ]
        sectionList.append(ExploreLocationSection(exploreLocationSectionList: exproleLocationList))
    }
    
    func generateUsersSection() {
        let usersSectionList: [UsersCellModel] = [
            UsersCellModel(image: "ben", name: "Serhat", age: 22, city: "Şanlıurfa, Türkiye"),
            UsersCellModel(image: "ben2", name: "Sosa", age: 20, city: "Roma, İtalya"),
            UsersCellModel(image: "ben4", name: "Hans", age: 25, city: "Frankurt, Almanya"),
            UsersCellModel(image: "defaultPP", name: "Jessica", age: 27, city: "Londra, İngiltere"),
            UsersCellModel(image: "defaultPP", name: "Shinju", age: 29, city: "Tokyo, Japonya"),
        ]
        sectionList.append(UserSection(userSectionList: usersSectionList))
    }
    func removeUserItem(section: Int) {
        if sectionList.isEmpty == false {
            print(sectionList[section])
        }
    }
    func getSectionsCount() -> Int {
        return sectionList.count
    }
    
    func getSection(at section: Int) -> SectionModel {
        return sectionList[section]
    }
}
