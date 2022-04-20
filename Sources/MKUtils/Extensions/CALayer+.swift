//
//  CALayer+.swift
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension CALayer {
    // Sketch 스타일의 그림자를 생성하는 유틸리티 함수
    func applyShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4
    ) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        cornerRadius = 20.0
        maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}

#endif

