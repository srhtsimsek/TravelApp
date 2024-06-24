//
//  UserSearchViewModel.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 3.06.2024.
//

import Foundation

class UserSearchViewModel {
    var userList: [UserModel] = []
    var filteredUsersList: [UserModel] = []
    
    var rowHeight: CGFloat {
        return 60
    }
    
    var isSearching: Bool {
        return filteredUsersList.count > 0
    }
    
    init() {
        fetchUsers()
    }
    
    func searchedText(_ text: String) {
        filteredUsersList = userList.filter({$0.username.contains(text) || $0.fullName.lowercased().contains(text)})
        
    }
    
    func fetchUsers() {
        DispatchQueue.main.async {
            UserService.shared.fetchAllUsers { [weak self] users in
                guard let self = self else { return }
                guard let users = users else { return }
                self.userList = users
            }
        }
    }
}
