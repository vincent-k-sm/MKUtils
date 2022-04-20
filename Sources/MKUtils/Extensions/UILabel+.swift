#if canImport(UIKit)
import UIKit

public extension UILabel {
    func countLines() -> Int {
        guard let myText = self.text as NSString? else {
            return 0
        }
        // Call self.layoutIfNeeded() if your view uses auto layout
        let rect = CGSize(
            width: self.bounds.width,
            height: CGFloat.greatestFiniteMagnitude
        )
        
        let labelSize = myText.boundingRect(
            with: rect,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: self.font as Any],
            context: nil
        )
        
        return Int(ceil(CGFloat(labelSize.height) / self.font.lineHeight))
    }
}

public extension UILabel {
    func customLabel(string: String, withColor: UIColor?, underLine: Bool, bold: Bool) {
        
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: self.text!)
        
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: withColor!, range: (text! as NSString).range(of: string))
        
        if underLine {
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: (text! as NSString).range(of: string))
            attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: withColor!, range: (text! as NSString).range(of: string))
        }
        
        if bold {
            let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: font.pointSize)]
            let range = (string as NSString).range(of: string)
            attributedString.addAttributes(boldFontAttribute, range: range)
        }
        self.attributedText = attributedString
        
    }
}


#endif

