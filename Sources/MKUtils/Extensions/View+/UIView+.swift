//
//  UIView+.swift
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension UIView {
    func rotate(degrees: CGFloat) {

        let degreesToRadians: (CGFloat) -> CGFloat = { (degrees: CGFloat) in
            return degrees / 180.0 * CGFloat.pi
        }
        self.transform =  CGAffineTransform(rotationAngle: degreesToRadians(degrees))
        // If you like to use layer you can uncomment the following line
        // layer.transform = CATransform3DMakeRotation(degreesToRadians(degrees), 0.0, 0.0, 1.0)
    }
}

public extension UIView {

    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

public extension UIView {
    enum GradientDirections {
        case leftToRight
        case topToBottom
        case leftTopToBottomRight
        case leftBottomToTopRight
    }
    
    func setGradientBackground(direction: GradientDirections, colors: [UIColor], locations: [CGFloat]? = nil) {
        let currentContext = UIGraphicsGetCurrentContext()
        currentContext?.saveGState()
        defer { currentContext?.restoreGState() }

        let size = self.frame.size
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        guard let gradient = CGGradient(
            colorsSpace: CGColorSpaceCreateDeviceRGB(),
            colors: colors.map({ $0.cgColor }) as CFArray,
            locations: locations
        ) else {
            fatalError("Error pattern background")
        }

        let context = UIGraphicsGetCurrentContext()
        let directionArray: (start: CGPoint, end: CGPoint)
        
        
        switch direction {
                
            case .leftToRight: // 􀄫
                directionArray = (.zero, .init(x: size.width, y: 0))
            case .topToBottom: // 􀄩
                directionArray = (.zero, .init(x: 0, y: size.height))
            case .leftTopToBottomRight: // 􀱈
                directionArray = (.zero, .init(x: size.width, y: size.height))
            case .leftBottomToTopRight: // 􀄮
                directionArray = (.init(x: 0, y: size.height), .init(x: size.width, y: 0))
        }
        
        context?.drawLinearGradient(
            gradient,
            start: directionArray.start,
            end: directionArray.end,
            options: []
        )
        
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let image = gradientImage else {
            fatalError("gradientBackground Need to call after ViewDidLayoutSubview instead viewDidAppear")
        }
        self.backgroundColor = UIColor(patternImage: image)
    }
}

#endif

