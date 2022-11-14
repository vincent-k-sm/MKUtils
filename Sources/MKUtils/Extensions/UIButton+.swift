//
//  UIButton+.swift
//

#if canImport(UIKit)
import UIKit

public extension UIButton {
    func setBackgroundColor(
        _ color: UIColor,
        for state: UIControl.State
    ) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(backgroundImage, for: state)
    }
}

public extension UIButton {
    func alignTextBelow(_ value: CGFloat) {

        let spacing: CGFloat = -(value) / 2

        self.imageEdgeInsets = UIEdgeInsets(
            top: 0,
            left: spacing,
            bottom: 0,
            right: -spacing
        )
        
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: -spacing,
            bottom: 0,
            right: spacing
        )
        
        self.contentEdgeInsets = UIEdgeInsets(
            top: 0,
            left: spacing,
            bottom: 0,
            right: spacing
        )
    }
}

#endif

