//
//  AppDelegate.swift
//  MovieApp.assignment
//
//  Created by Salome Lapiashvili on 11.11.23.
//

import UIKit
import Kingfisher

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let cache = ImageCache.default
        configureCacheExpiration(cache: cache)
        return true
    }
    
    private func configureCacheExpiration(cache: ImageCache) {
        let expirationTime: TimeInterval = 7 * 24 * 60 * 60
        cache.memoryStorage.config.expiration = .seconds(expirationTime)
        cache.diskStorage.config.expiration = .seconds(expirationTime)
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
}

