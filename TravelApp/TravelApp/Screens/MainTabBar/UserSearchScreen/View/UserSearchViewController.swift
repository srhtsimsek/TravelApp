//
//  FeedViewController.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 18.05.2024.
//

import UIKit

final class UserSearchViewController: UITableViewController {
    //MARK: Properties
    let reuseIdentifier = "UserSearchCell"
    var viewModel = UserSearchViewModel()
    
    //MARK: View
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.definesPresentationContext = false
        searchController.automaticallyShowsCancelButton = false
        searchController.searchBar.placeholder = "Search"
        return searchController
    }()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "seyyahları keşfet"
        configureTableView()
        configureSearchBar()
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        searchController.isActive = true
    }
    
    //MARK: Helpers
    func configureSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
    }
    func configureTableView() {
        view.backgroundColor = .white
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
}

//MARK: -Extension
//MARK:  UITableViewDataSource
extension UserSearchViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.isSearching ? viewModel.filteredUsersList.count : viewModel.userList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchTableViewCell
        if viewModel.isSearching {
            let user = viewModel.filteredUsersList[indexPath.row]
            cell.viewModel = CellViewModel(user: user)
            return cell
        } else {
            let user = viewModel.userList[indexPath.row]
            cell.viewModel = CellViewModel(user: user)
            return cell
        }
    }
}

//MARK:  UITableViewDelegate
extension UserSearchViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.rowHeight
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = viewModel.isSearching ? viewModel.filteredUsersList[indexPath.row] : viewModel.userList[indexPath.row]
        
        let userVC = ProfilViewController(user: user)
        self.navigationController?.pushViewController(userVC, animated: true)
    }
}

//MARK: SearchResulUpdate
extension UserSearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text?.lowercased().trimmingCharacters(in: .whitespaces)
    
        guard let searchText = searchText else { return }
        viewModel.searchedText(searchText)
        tableView.reloadData()
    }
}
