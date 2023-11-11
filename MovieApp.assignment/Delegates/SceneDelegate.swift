//
//  SceneDelegate.swift
//  MovieApp.assignment
//
//  Created by Salome Lapiashvili on 11.11.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let someScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: someScene)
        let moviesTableViewController = MoviesTableViewController()
        let navigationController = UINavigationController(rootViewController: moviesTableViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
      
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
       
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
       
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
       
    }


}

