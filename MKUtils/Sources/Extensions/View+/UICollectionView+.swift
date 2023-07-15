//
//  UICollectionView+.swift
//  
//
//  Created by vincent on 2023/02/07.
//

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

#endif

