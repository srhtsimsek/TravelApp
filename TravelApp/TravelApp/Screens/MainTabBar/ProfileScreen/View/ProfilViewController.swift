//
//  UserViewController.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 18.05.2024.
//

import UIKit

final class ProfilViewController: UICollectionViewController {
    
    //MARK: Properties
    var user: UserModel

    //MARK: Init
    init(user: UserModel) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        setupBarButtons()
        checkIsFollowing()
    }

    //MARK: Helpers
    func setupBarButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .done, target: self, action: #selector(logOut))
        navigationItem.rightBarButtonItem?.tintColor = .red.withAlphaComponent(0.4)
    }
    
    @objc func logOut() {
        AuthService.shared.signOutUser { error in
            if let error = error {
                print("logout error \(error.localizedDescription)")
            }
            self.directToSignInScreen()
        }
    }
    
    func directToSignInScreen() {
        let vc = SignInViewController()
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
//      UIApplication.shared.keyWindow?.rootViewController = vc
    }
    
    func configureCollectionView() {
        collectionView.backgroundColor = .white
        navigationItem.title = user.username
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.reuseIdentifier)
        
        collectionView.register(ProfileHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileHeaderCollectionReusableView.reuseIdentifier)
    }
    
    //MARK: API
    func checkIsFollowing() {
        guard let uid = user.uid else { return }
        UserService.shared.checkIsUserFollowing(uid: uid) { isFollow in
            print(isFollow)
            self.user.isFollowing = isFollow
            self.collectionView.reloadData()
        }
    }
}

//MARK: UICollectionViewDataSource
extension ProfilViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.reuseIdentifier, for: indexPath) as! ProfileCollectionViewCell
        cell.backgroundColor = .red
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileHeaderCollectionReusableView.reuseIdentifier, for: indexPath)
        
        if let header = header as? ProfileHeaderCollectionReusableView {
            header.headerViewModel = ProfileHeaderViewModel(user: user)
            header.delegate = self
        }
        return header
    }
}

//MARK: UICollectinViewDelegate

//MARK: UICollectionViewDelegateFlowLayout
extension ProfilViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widght = (view.frame.width - 2) / 3
        return CGSize(width: widght, height: widght)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let widght = view.frame.width
        return CGSize(width: widght, height: 240)
    }
}

extension ProfilViewController: ProfileHeaderProtocol {
    func header(_ header: ProfileHeaderCollectionReusableView, viewModel: ProfileHeaderViewModel) {
        guard let isFollow = user.isFollowing else { return }
        guard let uid = viewModel.user.uid else { return }
        if viewModel.isCurrentUser {
            print("editProfile procces")
        } else if isFollow == true {
            UserService.shared.unFollowUser(who: uid) { error in
                if let error = error {
                    print("Kullanıcı takibi bırakılamadı: \(error.localizedDescription)")
                }
            }
            
        } else {
            UserService.shared.followUser(who: uid) { error in
                if let error = error {
                    print("Kullanıcı takip edilemedi: \(error.localizedDescription)")
                }
            }
        }
    }
}

