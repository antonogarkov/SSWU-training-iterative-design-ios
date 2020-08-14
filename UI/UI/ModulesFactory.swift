import UIKit
import Interactors

public enum ModulesFactory {
    public static func makeProductsModule(productsInteractor: ProductsListInteractor,
                                          basketInteractor: BasketInteractor) -> UIViewController {

        let productsVC = ProductsListViewController.instantiate()
        let productsPresenter = ProductsListPresenter(productsInteractor: productsInteractor,
                                                      basketInteractor: basketInteractor,
                                                      viewController: productsVC)
        productsVC.retainedObject = productsPresenter

        return productsVC
    }

    public static func makeBasketModule(basketInteractor: BasketInteractor) -> UIViewController {
        let basketVC = BasketViewController.instantiate()
        let basketPresenter = BasketPresenter(viewController: basketVC,
                                              interactor: basketInteractor)
        basketVC.retainedObject = basketPresenter

        return basketVC
    }

    public static func makeProfileModule(profileInteractor: ProfileInteractor) -> UIViewController {
        let profileVC = ProfileViewController.instantiate()
        let profilePresenter = ProfilePresenter(viewController: profileVC, interactor: profileInteractor)

        profileVC.retainedObject = profilePresenter

        return profileVC
    }

    public static func makeAddressesModule(addressesInteractor: AddressesListInteractor) -> UIViewController {
        let addressesVC = AddressesListViewController.instantiate()
        let addressesPresenter = AddressesListPresenter(
            viewController: addressesVC,
            interactor: addressesInteractor
        )
        addressesVC.retainedObject = addressesPresenter

        return addressesVC
    }

    public static func makeDeliveryTimesModule() -> UIViewController {
        return DeliveryTimesVC.instantiate()
    }

    public static func makeCreditCardInputModule() -> UIViewController {
        return CreditCardInputVC.instantiate()
    }

    public static func makeCheckoutModule() -> UIViewController {
        return CheckoutViewController.instantiate()
    }

    public static func makeAddAddressModule() -> UIViewController {
        return AddAddressViewController.instantiate()
    }

    public static func makeLoginModule(loginInteractor: LoginInteractor) -> UIViewController {
        let viewController = LoginViewController.instantiate()
        let presenter = LoginPresenter(viewController: viewController,
                                       interactor: loginInteractor)
        viewController.retainedObject = presenter
        return viewController
    }
}
