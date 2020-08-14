import Foundation

public final class APIService {
    public struct Product {
        public let id: UUID
        public let imageUrl: URL
        public let name: String
        public let description: String
        public let price: Double
    }

    public struct Address {
        public let id: UUID
        public let addressFirstLine: String
        public let addressSecondLine: String
        public let city: String
        public let state: String
        public let zip: String
    }

    public struct BasketItem {
        public let product: Product
        public let amountAdded: Double
    }

    public struct Basket {
        public let items: [BasketItem]
        public let overallPrice: Double

        public static let empty = Basket(items: [], overallPrice: 0)
    }

    let products = [
        Product(id: UUID(),
                imageUrl: URL(string: "https://i.pinimg.com/originals/da/a8/de/daa8de830c02a6d62bf3696faaae3d85.png")!,
                name: "THICK FLANK",
                description: "Thick flank beef - rear part",
                price: 8),
        Product(id: UUID(),
                imageUrl: URL(string: "https://i.pinimg.com/originals/da/a8/de/daa8de830c02a6d62bf3696faaae3d85.png")!,
                name: "RUMP",
                description: "Rump beef - rear back part",
                price: 9),
        Product(id: UUID(),
                imageUrl: URL(string: "https://i.pinimg.com/originals/da/a8/de/daa8de830c02a6d62bf3696faaae3d85.png")!,
                name: "SIRLOIN",
                description: "Sirloin beef - back part",
                price: 16),
        Product(id: UUID(),
                imageUrl: URL(string: "https://i.pinimg.com/originals/da/a8/de/daa8de830c02a6d62bf3696faaae3d85.png")!,
                name: "THICK RIB",
                description: "Thick rib - chest part",
                price: 4)
        ]

    var basket = [UUID: Double]()
    var userEmail: String?
    var addresses = [Address]()

    public init() {}
}

// addresses
extension APIService {
    public func postAddress(addressFirstLine: String,
                            addressSecondLine: String,
                            city: String,
                            state: String,
                            zip: String) {

        addresses.append(
            Address(id: UUID(),
                    addressFirstLine: addressFirstLine,
                    addressSecondLine: addressSecondLine,
                    city: city,
                    state: state,
                    zip: zip
            )
        )
    }

    public func getAddresses() -> [Address] {
        addresses
    }
}

// products
extension APIService {
    public func getProducts() -> [Product] {
        products
    }
}

// profile
extension APIService {
    public func login(email: String, password: String) -> Bool {
        userEmail = email
        return true
    }

    public func getProfileEmail() -> String {
        userEmail ?? "guest@farm.com"
    }
}

// basket
extension APIService {
    public func getBasket() -> Basket {
        var basketPrice: Double = 0

        let items = basket.map { (id, amount) -> BasketItem in
            let product = (self.products.first { $0.id == id })!
            basketPrice += amount * product.price
            return BasketItem(product: product, amountAdded: amount)
        }

        return Basket(items: items, overallPrice: basketPrice)
    }

    public func incrementProductInBasket(uuid: UUID) -> Basket {
        let currentAmount = basket[uuid]
        basket[uuid] = (currentAmount ?? 0) + 0.1

        return getBasket()
    }

    public func decrementProductInBasket(uuid: UUID) -> Basket {
        if let currentAmount = basket[uuid] {
            let newAmount = currentAmount - 0.1
            if newAmount > 0 {
                basket[uuid] = newAmount
            } else {
                basket[uuid] = nil
            }
        }

        return getBasket()
    }
}
