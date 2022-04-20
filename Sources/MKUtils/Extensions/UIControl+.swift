import Foundation
#if canImport(UIKit)
import UIKit

// MARK: - UIButton Extension (UIControl Extension - add action)
// for  UIButton AddAction Every where
extension UIControl: Actionable {}

public protocol Actionable {
    associatedtype T = Self
    func addAction(for controlEvent: UIControl.Event, action: ((T) -> Void)?)
}

private class ClosureSleeve<T> {
    let closure: ((T) -> Void)?
    let sender: T

    init (sender: T, _ closure: ((T) -> Void)?) {
        self.closure = closure
        self.sender = sender
    }

    deinit {
        Debug.print("")
    }
    
    @objc
    func invoke() {
        closure?(sender)
    }
}

public extension Actionable where Self: UIControl {
    func addAction(for controlEvent: UIControl.Event, action: ((Self) -> Void)?) {
        
        let previousSleeve = objc_getAssociatedObject(self, String(controlEvent.rawValue))
        objc_removeAssociatedObjects(previousSleeve as Any)
        removeTarget(previousSleeve, action: nil, for: controlEvent)

        let sleeve = ClosureSleeve(sender: self, action)
        addTarget(sleeve, action: #selector(ClosureSleeve<Self>.invoke), for: controlEvent)
        objc_setAssociatedObject(self, String(controlEvent.rawValue), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}
#endif

