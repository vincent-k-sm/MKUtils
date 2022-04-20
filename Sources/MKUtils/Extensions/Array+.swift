//
//  Array+.swift
//

import Foundation

public extension Array where Element: Equatable {
    func nextItem(after: Element) -> Element? {
        if let index = self.firstIndex(of: after), index + 1 < self.count {
            return self[index + 1]
        }
        return nil
    }
    
    func previousItem(from: Element) -> Element? {
        if let index = self.firstIndex(of: from), index - 1 >= 0 {
            return self[index - 1]
        }
        return nil
    }
}
