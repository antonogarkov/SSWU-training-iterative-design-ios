import UIKit
import Interactors
import Services
import UI

final class CheckoutRouter {
    let apiService: APIService
    let basketInteractor: BasketInteractor
    let didFinish: () -> Void

    init(apiService: APIService, basketInteractor: BasketInteractor, didFinish: @escaping () -> Void) {
        self.apiService = apiService
        self.basketInteractor = basketInteractor
        self.didFinish = didFinish
    }

    func start() -> UIViewController {
        let checkoutInteractor = CheckoutInteractor(
            apiService: apiService,
            didSubmitOrder: { [weak self] in
                self?.didFinish()
            }
        )

        let addressesListModule = ModulesFactory.makeCheckoutAddressSelectionModule(
            addressesInteractor: AddressesListInteractor(apiService: apiService),
            checkoutInteractor: checkoutInteractor
        )

        let timesModule = ModulesFactory.makeDeliveryTimesModule(interactor: checkoutInteractor)

        let creditCardModule = ModulesFactory.makeCreditCardInputModule(interactor: checkoutInteractor)

        let basketModule = ModulesFactory.makeBasketModule(
            basketInteractor: basketInteractor,
            showsNavigation: false,
            didSelectCheckout: {}
        )

        let checkoutViewController = ModulesFactory.makeCheckoutModule(
            interactor: checkoutInteractor,
            embeddedViewControllers: [
                ModulesFactory.titleCheckoutModule(viewController: addressesListModule,
                                                   withTitle: "SELECT DELIVERY ADDRESS"),
                ModulesFactory.titleCheckoutModule(viewController: timesModule,
                                                   withTitle: "SELECT DELIVERY TIME"),
                ModulesFactory.titleCheckoutModule(viewController: creditCardModule,
                                                   withTitle: "SPECIFY YOUR PAYMENT CARD"),
                ModulesFactory.titleCheckoutModule(viewController: basketModule,
                                                   withTitle: "REVIEW YOUR ORDER")
            ]
        )

        return checkoutViewController
    }
}
