import UIKit

/// Load ViewController from Storyboard
public protocol StoryboardInstantiatable: class {
    /// Override the storyboardName if storyboard file has different name
    static var storyboardName: String { get }
}

public extension StoryboardInstantiatable {
    static var storyboardName: String { return String(describing: self) }
    static var bundleName: Bundle { return Bundle(for: self) }

    static func instantiate() -> Self {
        return instantiateWithName(name: storyboardName)
    }

    static func instantiateWithName(name: String) -> Self {
        let storyboard = UIStoryboard(name: name, bundle: Bundle(for: self))
        guard let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? Self
            else { fatalError("failed to load \(name) storyboard file.") }
        return viewController
    }
}
