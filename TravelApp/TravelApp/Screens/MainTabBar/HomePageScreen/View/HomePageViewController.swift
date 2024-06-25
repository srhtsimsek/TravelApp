//
//  MainViewController.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 18.05.2024.
//

import UIKit
import Firebase

final class HomePageViewController: UIViewController {
    
    //MARK: View
    private let scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.backgroundColor = .white
        
        //        scrollview.showsVerticalScrollIndicator = false
        return scrollview
    }()
    private let scrollContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let homePageSearchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 300, height: 20))
        searchBar.placeholder = "countries, cities, voyagers..."
        searchBar.autocapitalizationType = .none
        searchBar.autocorrectionType = .no
        searchBar.layer.cornerRadius = 18
        searchBar.layer.masksToBounds = true
        return searchBar
    }()
    
    private let servicesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 40
        //        layout.minimumInteritemSpacing = 30
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.layer.cornerRadius = 10
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.layer.masksToBounds = true
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

//    private let bookFlightView: UIView = {
//        let view = UIView()
//        return view
//    }()
//    private let rentCarView: UIView = {
//        let view = UIView()
//        return view
//    }()
    private let bookStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 40
        return stackView
    }()
    private let flightimageView: UIImageView = {
        let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 150))
        imageview.contentMode = .scaleAspectFill
//        imageview.image = .plane
        return imageview
    }()
    private let viewForflight: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        return view
    }()
    private let rentCarimageView: UIImageView = {
        let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 150))
        imageview.contentMode = .scaleAspectFill
//        imageview.image = .car
        return imageview
    }()
    
    private let flightLabel = CustomLabel(title: "Flight Ticket", font: .bold, fontSize: .medium)
    private let rentCarLabel = CustomLabel(title: "Rent a Car", font: .bold, fontSize: .medium)
    
    //MARK: Properties
    private let viewModel = HomePageViewModel()

    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        buildCollectionView()
        setCompositionalLayout()
    }

    //MARK: Helpers
    func redirectToServiceVC(tag buttonTag: Int) {
        switch buttonTag {
        case 0:
            print("to events VC")
            let vc = UserSearchViewController()
            vc.navigationItem.title = "Events"
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            print("to hotels VC")
            //                let vc = FeedViewController()
            //                self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            print("to weather VC")
            //                let vc = FeedViewController()
            //                self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            print("to button4 VC")
            //                let vc = FeedViewController()
            //                self.navigationController?.pushViewController(vc, animated: true)
        case 4:
            print("to button5 VC")
        default:
            print("deneme")
        }
    }
    
    //MARK: Config UI
    private func configUI() {
        confignavigationBar()
        view.backgroundColor = .white
        configScrollView()
    }

    private func configScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContainer)
        view.addSubview(homePageSearchBar)
        scrollContainer.addSubview(servicesCollectionView)
        
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        let scrollContentGuide = scrollView.contentLayoutGuide
        let scrollFrameGuide = scrollView.frameLayoutGuide
        
        scrollContainer.anchor(top: scrollContentGuide.topAnchor,
                               left: scrollContentGuide.leftAnchor,
                               bottom: scrollContentGuide.bottomAnchor,
                               right: scrollContentGuide.rightAnchor)
        
        scrollContainer.anchor(left: scrollFrameGuide.leftAnchor,
                               right: scrollFrameGuide.rightAnchor,
                               height: 1200)
        
        homePageSearchBar.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                 left: view.leftAnchor,
                                 right: view.rightAnchor,
                                 paddingTop: 10,
                                 paddingLeft: 10,
                                 paddingRight: 10)

        servicesCollectionView.anchor(top: scrollContainer.topAnchor, left: scrollContainer.leftAnchor, right: scrollContainer.rightAnchor, paddingTop: 75, paddingLeft: 0, paddingRight: 0, height:  600)

    }
    
    func confignavigationBar() {
        navigationItem.title = "seyyah"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "message"), style: .done, target: self, action: #selector(messageVC))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target: nil, action: nil)
        
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    //message
    @objc func messageVC() {
//        AuthService.shared.signOutUser { error in
//            if let error = error {
//                print("logout error \(error.localizedDescription)")
//            }
//            self.directToSignInScreen()
//        }
    }
}

extension HomePageViewController {
    func buildCollectionView() {
        servicesCollectionView.delegate = self
        servicesCollectionView.dataSource = self
        
        servicesCollectionView.register(ExploreLocationHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ExploreLocationHeaderView.headerIdentifier)
        
        servicesCollectionView.register(UsersCellHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: UsersCellHeaderView.headerIdentifier)
        
        servicesCollectionView.register(QuickAccessCollectionViewCell.self, forCellWithReuseIdentifier: QuickAccessCollectionViewCell.reuseIdentifier)
        
        servicesCollectionView.register(ExploreLocationCollectionViewCell.self, forCellWithReuseIdentifier: ExploreLocationCollectionViewCell.reuseIdentifier)
        
        servicesCollectionView.register(UsersCollectionViewCell.self, forCellWithReuseIdentifier: UsersCollectionViewCell.reuseIdentifier)
    }
    
    func setCompositionalLayout() {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, env -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            let sectionType = self.viewModel.getSection(at: sectionIndex).cellType
            
            return self.layoutSection(for: sectionType)
        }
        
        servicesCollectionView.setCollectionViewLayout(layout, animated: true)
    }

    private func layoutSection(for cellType: HomePageCellType) -> NSCollectionLayoutSection {
        switch cellType {
        case .quickAccessCell:
            return CompositionalLayoutManager.sharedInstance.createLayoutSection(layoutType: .horizontal)
        case .exploreLocationCell:
            return CompositionalLayoutManager.sharedInstance.createLayoutSection(layoutType: .normal(headerIdentifier: ExploreLocationHeaderView.headerIdentifier))
        case .usersCell:
            return CompositionalLayoutManager.sharedInstance.createLayoutSection(layoutType: .users(headerIdentifier: UsersCellHeaderView.headerIdentifier))
        }
    }
    
}

extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.getSectionsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getSection(at: section).itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = viewModel.getSection(at: indexPath.section)
        let item = section.getItem(at: indexPath.row)
        
        switch section.cellType {
        case .quickAccessCell:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuickAccessCollectionViewCell.reuseIdentifier, for: indexPath) as! QuickAccessCollectionViewCell
            if let serviceModel = item as? QuickAccessCellModel {
                cell.setup(model: serviceModel)
            }
            return cell
        case .exploreLocationCell:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreLocationCollectionViewCell.reuseIdentifier, for: indexPath) as! ExploreLocationCollectionViewCell
            if let exploreModel = item as? ExploreLocationCellModel {
                print(cell)
                cell.setupData(model: exploreModel)
            }
            return cell
        case .usersCell:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UsersCollectionViewCell.reuseIdentifier, for: indexPath) as! UsersCollectionViewCell
            cell.followButton.tag = indexPath.row
//            cell.tappedButton = {
//                print("cell button tapped \(cell.followButton.tag)")
//            }
            
            if let usersModel = item as? UsersCellModel {
                cell.setup(model: usersModel)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = viewModel.getSection(at: indexPath.section)
        
        if section.cellType == .exploreLocationCell {
            if kind == UICollectionView.elementKindSectionHeader {
                let headerView: ExploreLocationHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ExploreLocationHeaderView.headerIdentifier, for: indexPath) as! ExploreLocationHeaderView
                return headerView
            }
        }
        if section.cellType == .usersCell {
            if kind == UICollectionView.elementKindSectionHeader {
                let headerView: UsersCellHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: UsersCellHeaderView.headerIdentifier, for: indexPath) as! UsersCellHeaderView
                headerView.delegate = self
                return headerView
            }
            
        }
        fatalError("headerview error")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = viewModel.getSection(at: indexPath.section)
        let item = section.getItem(at: indexPath.row)
        
        switch section.cellType {
        case .quickAccessCell:
            print("item: \(item as? QuickAccessCellModel)")
        case .exploreLocationCell:
            print("item: \(item as? ExploreLocationCellModel)")
        case .usersCell:
            print("item: \(item as? UsersCellModel)")
            
        }
    }
}

extension HomePageViewController: UIScrollViewDelegate {
        
}
//MARK: User HeaderView Delegate
extension HomePageViewController: HeaderViewDelegate {
    func seeAllUsersButtonTapped() {
        let userSearchVC = UserSearchViewController()
        self.navigationController?.pushViewController(userSearchVC, animated: true)
    }
}
