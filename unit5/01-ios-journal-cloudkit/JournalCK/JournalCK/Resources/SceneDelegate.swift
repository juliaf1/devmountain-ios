//
//  SceneDelegate.swift
//  JournalCK
//
//  Created by Julia Frederico on 22/11/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let navController = UINavigationController()
        navController.viewControllers = [EntryListViewController(), EntryDetailViewController()]
        
        let window = UIWindow(windowScene: scene)
        window.rootViewController = navController
        self.window = window
        window.makeKeyAndVisible()
    }

}

