import Foundation
// MARK: - Properties
public extension NSAttributedString {

    #if !os(Linux)
    /// SwifterSwift: Dictionary of the attributes applied across the whole string
    var attributes: [NSAttributedString.Key: Any] {
        guard self.length > 0 else { return [:] }
        return attributes(at: 0, effectiveRange: nil)
    }
    #endif

}
