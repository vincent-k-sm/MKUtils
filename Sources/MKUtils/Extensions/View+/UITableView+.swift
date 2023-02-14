//
//  UITableView+.swift
//  
//
//  Created by vincent on 2023/02/06.
//

#if canImport(UIKit)
import UIKit

public extension UITableView {
    
    /**
     Register nibs faster by passing the type - if for some reason the `identifier` is different then it can be passed
     - Parameter type: UITableViewCell.Type
     - Parameter identifier: String?
     */
    
    func registerCell(type: UITableViewCell.Type, fromNib: Bool = false) {
        if fromNib {
            register(UINib(nibName: type.identifier, bundle: nil), forCellReuseIdentifier: type.identifier)
        }
        else {
            self.register(type, forCellReuseIdentifier: type.identifier)
        }
    }
    
    func registerCell(type: UITableViewHeaderFooterView.Type, fromNib: Bool = false) {
        if fromNib {
            register(UINib(nibName: type.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: type.identifier)
        }
        else {
            self.register(type, forHeaderFooterViewReuseIdentifier: type.identifier)
        }
    }
    
    /**
     DequeueCell by passing the type of UITableViewCell
     - Parameter type: UITableViewCell.Type
     */
    func dequeueCell<T: UITableViewCell>(withType type: UITableViewCell.Type) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier) as? T
    }
    
    func dequeueCell<T: UITableViewHeaderFooterView>(withType type: UITableViewHeaderFooterView.Type) -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: type.identifier) as? T
    }
    
    /**
     DequeueCell by passing the type of UITableViewCell and IndexPath
     - Parameter type: UITableViewCell.Type
     - Parameter indexPath: IndexPath
     */
    func dequeueCell<T: UITableViewCell>(withType type: UITableViewCell.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as? T
    }
    
    func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
}

#endif

