//
//  AppDelegate.swift
//  RedditClone
//
//  Created by William Huynh on 12/21/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var coordinator: RedditCoordinator?
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let navController = UINavigationController()
        
        // send that into our coordinator so that it can display view controllers
        coordinator = RedditCoordinator(navigationController: navController)
        
        // tell the coordinator to take over control
        coordinator?.start()
        
        // create a basic UIWindow and activate it
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

