//
//  MainViewController.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 17.05.2024.
//

import UIKit
import FirebaseAuth

final class TabBarController: UITabBarController {
    
    private var viewModel = TabBarControllerViewModel()
    
    //MARK: View
    private let viewActityIndocator: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isHidden = true
        return view
    }()
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.color = .purple
        return indicator
    }()
    private let activityIndicatorImage: UIImageView = {
        let imageview = UIImageView(image: ._1)
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()

    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        showLoadingView()
        bindViewModel()
    }

    override func viewDidAppear(_ animated: Bool) {
//        checkUserIsLogIn()
        viewModel.checkUserIsLogin()
    }
    
    //MARK: Helpers
    private func bindViewModel() {
        viewModel.userDidChange = { [weak self] user in
            if let user = user {
                self?.configureTabViewControllers(with: user)
                self?.hideLoadingView()
            } else {
                self?.redirectToSignInVC()
            }
        }
    }
    private func redirectToSignInVC() {
        let signInVC = SignInViewController()
        let nav = UINavigationController(rootViewController: signInVC)
        nav.modalPresentationStyle = .fullScreen
        nav.navigationBar.isHidden = true
        self.present(nav, animated: true)
    }
    
    func showLoadingView() {
        DispatchQueue.main.async {
            self.viewActityIndocator.isHidden = false
            self.activityIndicator.startAnimating()
        }
    }
    func hideLoadingView() {
        DispatchQueue.main.async {
            self.viewActityIndocator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func configureTabViewControllers(with user: UserModel) {
        view.backgroundColor = .white
        tabBar.isTranslucent = true
        
        let homeVC = configureNavigationController(unselectedImage: .homeIconUnSelected, selectedImage: .homeIconSelected, imageRenderinMode: .alwaysOriginal, rootViewController: HomePageViewController())

        let feedVC = configureNavigationController(unselectedImage: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"), rootViewController: UserSearchViewController())
        
//        let findMateVC = configureNavigationController(unselectedImage: UIImage(systemName: "message"), selectedImage: UIImage(systemName: "message.fill"), imageRenderinMode: .alwaysOriginal ,rootViewController: FindMateViewController())
//
        let profileVC = configureNavigationController(unselectedImage: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"), rootViewController: ProfilViewController(user: user))
        
        viewControllers = [homeVC, feedVC/*, findMateVC*/, profileVC]
        tabBar.tintColor = .black
    }

    func configureNavigationController(unselectedImage: UIImage?, selectedImage: UIImage?, imageRenderinMode: UIImage.RenderingMode = .alwaysOriginal, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage?.withRenderingMode(imageRenderinMode)
        nav.tabBarItem.selectedImage = selectedImage?.withRenderingMode(imageRenderinMode)
        return nav
    }
    
    func configureUI() {
        view.addSubview(viewActityIndocator)
        viewActityIndocator.addSubview(activityIndicatorImage)
        viewActityIndocator.addSubview(activityIndicator)
        
        viewActityIndocator.fillView()
        activityIndicatorImage.center(in: view)
        activityIndicatorImage.setDimensions(height: 300, width: 200)
        activityIndicator.anchor(top: activityIndicatorImage.topAnchor, left: activityIndicatorImage.leftAnchor, paddingTop: 120, paddingLeft: 45)
    }
}
