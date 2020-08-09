import Foundation

public final class APIService {
    struct Product {
        let id: UUID
        let imageUrl: URL
        let name: String
        let description: String
        let price: Double
    }

    struct Address {
        let id: UUID
        let addressFirstLine: String
        let addressSecondLine: String
        let city: String
        let state: String
        let zip: String
    }

    struct BasketItem {
        let product: Product
        let amountAdded: Double
    }

    struct Basket {
        let items: [BasketItem]
        let overallPrice: Double
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
}

extension APIService {
    func getProducts() -> [Product] {
        products
    }

    func getAddresses() -> Address {
        Address(
            id: UUID(),
            addressFirstLine: "Infinite Loop",
            addressSecondLine: "1",
            city: "Cupertino",
            state: "CA",
            zip: "95014"
        )
    }

    func getProfileEmail() -> String {
        "guest@farm.com"
    }

    func getBasket() -> Basket {
        var basketPrice: Double = 0

        let items = basket.map { (id, amount) -> BasketItem in
            let product = (self.products.first { $0.id == id })!
            basketPrice += amount * product.price
            return BasketItem(product: product, amountAdded: amount)
        }

        return Basket(items: items, overallPrice: basketPrice)
    }

    func incrementProductInBasket(uuid: UUID) -> Basket {
        let currentAmount = basket[uuid]
        basket[uuid] = (currentAmount ?? 0) + 0.1

        return getBasket()
    }

    func decrementProductInBasket(uuid: UUID) -> Basket {
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
