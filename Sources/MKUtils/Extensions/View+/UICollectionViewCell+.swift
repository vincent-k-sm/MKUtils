//
//  UICollectionViewCell+.swift
//  
//
//  Created by vincent on 2023/02/07.
//

#if canImport(UIKit)
import UIKit

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


public extension UICollectionReusableView {
    
    static var identifier: String {
        return String(describing: self)
    }
}

#endif

