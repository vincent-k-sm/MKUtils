//
//  Cancellable+Extensions.swift
//

import Combine
@available(macOS 10.15, *)
typealias Cancellable = Set<AnyCancellable>

@available(macOS 10.15, *)
public extension Cancellable {
    mutating func clear() {
        forEach { $0.cancel() }
        removeAll()
    }
}
