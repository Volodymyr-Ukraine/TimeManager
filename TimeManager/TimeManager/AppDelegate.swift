//
//  AppDelegate.swift
//  TimeManager
//
//  Created by Vladimir on 2/1/20.
//  Copyright © 2020 Volodymyr. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: -
    // MARK: Properties
    
    var window: UIWindow?
    var appConfigurator: AppConfigurator?
    
    // MARK: -
    // MARK: Methods
    
//    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        let _window = UIWindow(frame: UIScreen.main.bounds)
//        self.window = _window
////        let controller = LoadingViewController.startVC()
//        let navigationController = UINavigationController()
//        _window.rootViewController = navigationController
//        navigationController.navigationBar.isHidden = true
//        self.navContr = navigationController
//        self.window?.rootViewController = navigationController
////        navigationController.pushViewController(controller, animated: true)
////        self.window?.makeKeyAndVisible()
//        return true
//    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        guard let _window = self.window,
//                    let contr = self.navContr else {return false}
        let _window = UIWindow(frame: UIScreen.main.bounds)
        self.window = _window
        self.appConfigurator = AppConfigurator(window: _window)
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

