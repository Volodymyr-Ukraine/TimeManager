//
//  AppConfigurator.swift
//  TimeManager
//
//  Created by Vladimir on 2/1/20.
//  Copyright © 2020 Volodymyr. All rights reserved.
//

import UIKit

final class AppConfigurator {

    private var coordinator: Coordinator?

    init(window: UIWindow) {
        self.configure(window: window)
    }

    private func configure(window: UIWindow) {
                
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        navigationController.navigationBar.isHidden = true
        self.coordinator = ScreensCoordinator(navigationController: navigationController)
        self.coordinator?.start()
        window.makeKeyAndVisible()
    }

//    public func userGoogleAppeared(user: GIDGoogleUser?){
//        let coord = (self.coordinator as? ItemCoordinator)
//        coord?.user = user
//    }
}

