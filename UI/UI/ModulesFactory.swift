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

    public static func makeBasketModule(basketInteractor: BasketInteractor, didSelectCheckout: @escaping () -> Void) -> UIViewController {
        let basketVC = BasketViewController.instantiate()
        let basketPresenter = BasketPresenter(viewController: basketVC,
                                              interactor: basketInteractor,
                                              didSelectCheckout: didSelectCheckout)
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

    public static func makeCheckoutAddressSelectionModule(addressesInteractor: AddressesListInteractor,
                                                          checkoutInteractor: CheckoutInteractor) -> UIViewController {
        let addressesVC = AddressesListViewController.instantiate()
        let addressesPresenter = AddressesListCheckoutPresenter(
            viewController: addressesVC,
            addressesListInteractor: addressesInteractor,
            checkoutInteractor: checkoutInteractor
        )
        addressesVC.retainedObject = addressesPresenter

        return addressesVC
    }

    public static func makeDeliveryTimesModule(interactor: CheckoutInteractor) -> UIViewController {
        let timesViewController = DeliveryTimesVC.instantiate()
        let presenter = DeliveryTimesPresenter(viewController: timesViewController, checkoutInteractor: interactor)
        timesViewController.retainedObject = presenter

        return timesViewController
    }

    public static func makeCreditCardInputModule() -> UIViewController {
        return CreditCardInputVC.instantiate()
    }

    public static func makeCheckoutModule(interactor: CheckoutInteractor,
                                          embeddedViewControllers: [UIViewController]) -> UIViewController {
        let viewController = CheckoutViewController.instantiate()

        viewController.embeddedViewControllers = embeddedViewControllers

        let presenter = CheckoutPresenter(viewController: viewController,
                                          interactor: interactor)
        viewController.retainedObject = presenter
        return viewController
    }

    public static func makeAddAddressModule(addAddressInteractor: AddAddressInteractor) -> UIViewController {
        let viewController = AddAddressViewController.instantiate()
        let presenter = AddAddressPresenter(viewController: viewController,
                                            interactor: addAddressInteractor)
        viewController.retainedObject = presenter

        return viewController
    }

    public static func makeLoginModule(loginInteractor: LoginInteractor) -> UIViewController {
        let viewController = LoginViewController.instantiate()
        let presenter = LoginPresenter(viewController: viewController,
                                       interactor: loginInteractor)
        viewController.retainedObject = presenter
        return viewController
    }
}
