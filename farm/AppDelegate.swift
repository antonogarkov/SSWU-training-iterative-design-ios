//
//  AppDelegate.swift
//  farm
//
//  Created by Anton Ogarkov on 30.06.2020.
//  Copyright © 2020 SigmaSoftware. All rights reserved.
//

import UIKit
import UI
import Services
import Interactors

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let window = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        UITabBar.appearance().tintColor = UIColor.black

        let apiService = APIService()

        let basketVC = BasketViewController.instantiate()
        let basketInteractor = BasketInteractor(apiService: apiService)
        let basketPresenter = BasketPresenter(viewController: basketVC,
                                              interactor: basketInteractor)
        basketVC.retainedObject = basketPresenter

        let productsVC = ProductsListViewController.instantiate()
        let productsInteractor = ProductsListInteractor(apiService: apiService)
        let productsPresenter = ProductsListPresenter(productsInteractor: productsInteractor,
                                                      basketInteractor: basketInteractor,
                                                      viewController: productsVC)
        productsVC.retainedObject = productsPresenter

        let addressesVC = AddressesListViewController.instantiate()
        let addressesInteractor = AddressesListInteractor(apiService: apiService)
        let addressesPresenter = AddressesListPresenter(
            viewController: addressesVC,
            interactor: addressesInteractor
        )
        addressesVC.retainedObject = addressesPresenter

        let profileVC = ProfileViewController.instantiate()
        let profileInteractor = ProfileInteractor(apiService: apiService)
        let profilePresenter = ProfilePresenter(viewController: profileVC, interactor: profileInteractor)
        profileVC.retainedObject = profilePresenter

        let tabbarController = UITabBarController()

        tabbarController.tabBar.tintColor = .black
        tabbarController.tabBar.unselectedItemTintColor = UIColor(named: "BrandBlue")

        tabbarController.viewControllers = [
            productsVC,
            addressesVC,
            profileVC,
            basketVC
        ]

        window.rootViewController = tabbarController

        window.makeKeyAndVisible()

        return true
    }
}

