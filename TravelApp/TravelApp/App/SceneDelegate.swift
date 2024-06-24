//
//  SceneDelegate.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 27.04.2024.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        self.setupWindow(with: scene)
        self.checkFirstLaunch()
    }
    
    private func setupWindow(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
    }
    
    public func checkFirstLaunch() {
        let isLaunchedBefore: Bool = UserDefaults.standard.bool(forKey: "isLaunchedBefore")
        
        if isLaunchedBefore {
            let mainVC = TabBarController()
            window?.rootViewController = mainVC
        } else {
            window?.rootViewController = OnboardingViewController()
        }
    }
}

