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

        let basketInteractor = BasketInteractor(apiService: apiService)

        let tabbarController = UITabBarController()

        tabbarController.tabBar.tintColor = .black
        tabbarController.tabBar.unselectedItemTintColor = UIColor(named: "BrandBlue")

        tabbarController.viewControllers = [
            makeProductsModule(apiService: apiService, basketInteractor: basketInteractor),
            makeAddressesModule(apiService: apiService),
            makeProfileModule(apiService: apiService),
            makeBasketModule(apiService: apiService, basketInteractor: basketInteractor)
        ]

        window.rootViewController = tabbarController

        window.makeKeyAndVisible()

        return true
    }

    private func makeProductsModule(apiService: APIService,
                                    basketInteractor: BasketInteractor) -> ProductsListViewController {

        let productsVC = ProductsListViewController.instantiate()
        let productsInteractor = ProductsListInteractor(apiService: apiService)
        let productsPresenter = ProductsListPresenter(productsInteractor: productsInteractor,
                                                      basketInteractor: basketInteractor,
                                                      viewController: productsVC)
        productsVC.retainedObject = productsPresenter

        return productsVC
    }

    private func makeBasketModule(apiService: APIService, basketInteractor: BasketInteractor) -> BasketViewController {
        let basketVC = BasketViewController.instantiate()
        let basketPresenter = BasketPresenter(viewController: basketVC,
                                              interactor: basketInteractor)
        basketVC.retainedObject = basketPresenter

        return basketVC
    }

    private func makeProfileModule(apiService: APIService) -> ProfileViewController {
        let profileVC = ProfileViewController.instantiate()
        let profileInteractor = ProfileInteractor(apiService: apiService)
        let profilePresenter = ProfilePresenter(viewController: profileVC, interactor: profileInteractor)

        profileVC.retainedObject = profilePresenter

        return profileVC
    }

    private func makeAddressesModule(apiService: APIService) -> AddressesListViewController {
        let addressesVC = AddressesListViewController.instantiate()
        let addressesInteractor = AddressesListInteractor(apiService: apiService)
        let addressesPresenter = AddressesListPresenter(
            viewController: addressesVC,
            interactor: addressesInteractor
        )
        addressesVC.retainedObject = addressesPresenter

        return addressesVC
    }
}

