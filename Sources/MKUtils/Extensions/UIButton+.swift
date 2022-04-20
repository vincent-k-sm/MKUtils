//
//  UIButton+.swift
//

#if canImport(UIKit)
import UIKit

public extension UIButton {
    func alignTextBelow(spacing: CGFloat = 2.0) {
        
        let insetAmount = spacing / 2
        // background color가 사라짐
//        if #available(iOS 15.0, *) {
//
//            var configuration = UIButton.Configuration.filled()
//            configuration.baseBackgroundColor = .clear
//            configuration.imagePadding = spacing
//            configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: insetAmount, bottom: 0, trailing: insetAmount)
//
//            self.configuration = configuration
//
//        }
//        else {
//            let isRTL = UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .rightToLeft
//            if isRTL {
//               imageEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
//               titleEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
//               contentEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: -insetAmount)
//            } else {
               imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
               titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
               contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
//            }
//        }
        
    }
}

public struct ButtonSizeModel {
    var height: CGFloat
    
}

public enum CustomButtonSize: CaseIterable {
    case medium
    case small
    
    var style: ButtonSizeModel {
        switch self {
            case .medium:
                let model = ButtonSizeModel(height: 48.0)
                return model

            case .small:
                let model = ButtonSizeModel(height: 44.0)
                return model
                
        }
    }
}

public extension UIButton {
    
    func setTitle(text: String,
                  color: UIColor,
                  state: [UIControl.State] = [.normal, .highlighted, .disabled],
                  alpha: CGFloat = 1.0) {
        
        for i in state {
            let attributeString = NSMutableAttributedString(string: text)
            var attr: [NSAttributedString.Key: Any] = [:]
            attr[.font] = UIFont.systemFont(ofSize: 16.0, weight: .bold)
            attr[.foregroundColor] = color
            attributeString.addAttributes(attr, range: NSRange(location: 0, length: attributeString.length))
            self.setAttributedTitle(attributeString, for: i)
            
        }
    }
}
#endif

