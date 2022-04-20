import Foundation
#if canImport(UIKit)
import UIKit

public extension UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var tableView: UITableView? {
        get {
            var table: UIView? = superview
            while !(table is UITableView) && table != nil {
                let newSuperview = table?.superview
                table = newSuperview
            }
            return table as? UITableView
        }
    }
    
    var indexPath: IndexPath? {
        return tableView?.indexPath(for: self)
    }
    
}

public extension UITableViewHeaderFooterView {
    static var identifier: String {
        return String(describing: self)
    }
}

public extension UICollectionViewCell {
    var collectionView: UICollectionView? {
        get {
            var cv: UIView? = superview
            while !(cv is UICollectionView) && cv != nil {
                let newSuperview = cv?.superview
                cv = newSuperview
            }
            return cv as? UICollectionView
        }
    }
}

#endif

