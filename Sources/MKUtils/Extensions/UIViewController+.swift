
#if canImport(UIKit)
import UIKit

public extension UIViewController {
    func topMostViewController() -> UIViewController {
        if self.presentedViewController == nil {
            return self
        }
        if let navigation = self.presentedViewController as? UINavigationController {
            return navigation.visibleViewController!.topMostViewController()
        }
        if let tab = self.presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        return self.presentedViewController!.topMostViewController()
    }
}

public extension UIViewController {
    
    func addVc(_ vc: UIViewController) {
        self.addChild(vc)
        self.view.addSubview(vc.view)
    }
    
    func removeVc() {
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
}

public extension UIViewController {
    
    @objc
    static func topMost() -> UIViewController? {
        if let window = UIWindow.key, let vc = window.rootViewController {
            return vc.findBestViewController()
        }
        return nil
    }
    
    func findBestViewController() -> UIViewController {
        if let vc = self.presentedViewController {
            return vc.findBestViewController()
        }
        else if self is UISplitViewController {
            let svc = self as! UISplitViewController
            if let vc = svc.viewControllers.last {
                return vc.findBestViewController()
            }
            else {
                return self
            }
        }
        else if self is UINavigationController {
            let svc = self as! UINavigationController
            if let vc = svc.topViewController {
                return vc.findBestViewController()
            }
            else {
                return self
            }
        }
        else if self is UITabBarController {
            let svc = self as! UITabBarController
            if let vc = svc.selectedViewController {
                return vc.findBestViewController()
            }
            else {
                return self
            }
        }
        return self
    }
}

public extension UIViewController {
    var isModal: Bool {
        if let index = navigationController?.viewControllers.firstIndex(of: self), index > 0 {
            return false
        }
        else if presentingViewController != nil {
            return true
        }
        else if navigationController?.presentingViewController?.presentedViewController == navigationController {
            return true
        }
        else if tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        else {
            return false
        }
    }
}
#endif
