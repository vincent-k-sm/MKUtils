import Foundation
#if canImport(UIKit)
import UIKit

public extension UICollectionViewCompositionalLayout {
    func registerCell(type: UICollectionReusableView.Type) {
        register(type, forDecorationViewOfKind: type.identifier)
    }
}

public extension UICollectionView {
	
	/**
	 Register nibs faster by passing the type - if for some reason the `identifier` is different then it can be passed
	 - Parameter type: UICollectionView.Type
	 - Parameter identifier: String?
	 */
    func registerCell(type: UICollectionViewCell.Type, fromNib: Bool = false) {
        if fromNib {
            register(UINib(nibName: type.identifier, bundle: nil), forCellWithReuseIdentifier: type.identifier)
        }
        else {
            register(type, forCellWithReuseIdentifier: type.identifier)
        }
        
    }
    
    func registerCell(type: UICollectionReusableView.Type, fromNib: Bool = false) {
        if fromNib {
            register(UINib(nibName: type.identifier, bundle: nil), forSupplementaryViewOfKind: type.identifier, withReuseIdentifier: type.identifier)
        }
        else {
            
            register(type, forSupplementaryViewOfKind: type.identifier, withReuseIdentifier: type.identifier)
        }
        
    }
    
	/**
	 DequeueCell by passing the type of UICollectionViewCell and IndexPath
	 - Parameter type: UICollectionViewCell.Type
	 - Parameter indexPath: IndexPath
	 */
	func dequeueCell<T: UICollectionViewCell>(withType type: UICollectionViewCell.Type, for indexPath: IndexPath) -> T? {
		return dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath) as? T
	}
	
	func dequeueCell<T: UICollectionReusableView>(withType type: UICollectionReusableView.Type, for indexPath: IndexPath) -> T? {
		return dequeueReusableSupplementaryView(ofKind: type.identifier, withReuseIdentifier: type.identifier, for: indexPath) as? T
	}
	
}
public extension UICollectionReusableView {
	
	static var identifier: String {
		return String(describing: self)
	}
}

public extension UICollectionView {
	func scrollToTop(_ animate: Bool) {
		let inset = self.contentInset
		let point = CGPoint(x: 0, y: 0 - inset.top)
		self.setContentOffset(point, animated: animate)
		
	}
}

public extension UICollectionView {
    /// Extensions shouldn't override declarations
//    open override func touchesShouldCancel(in view: UIView) -> Bool {
//        if view is UIButton {
//            return true
//        }
//        return super.touchesShouldCancel(in: view)
//    }
    
    func removeEventDelay() {
        self.delaysContentTouches = false
        self.canCancelContentTouches = true

        for case let subview as UIScrollView in self.subviews {
            subview.delaysContentTouches = false
        }
    }
}

#endif

