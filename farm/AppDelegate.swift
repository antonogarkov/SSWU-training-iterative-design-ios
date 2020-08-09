//
//  AppDelegate.swift
//  farm
//
//  Created by Anton Ogarkov on 30.06.2020.
//  Copyright © 2020 SigmaSoftware. All rights reserved.
//

import UIKit
import UI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let window = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        UITabBar.appearance().tintColor = UIColor.black

        let tabbarController = UITabBarController()

        tabbarController.tabBar.tintColor = .black
        tabbarController.tabBar.unselectedItemTintColor = UIColor(named: "BrandBlue")

        tabbarController.viewControllers = [
            ProductsListViewController.instantiate(),
            AddressesListViewController.instantiate(),
            ProfileViewController.instantiate(),
            BasketViewController.instantiate()
        ]

        window.rootViewController = tabbarController

        window.makeKeyAndVisible()

        return true
    }
}

