//
//  MemoryAddress.swift
//

import Foundation

public struct MemoryAddress<T>: CustomStringConvertible {

    let intValue: Int

    public var description: String {
        let length = 2 + 2 * MemoryLayout<UnsafeRawPointer>.size
        return String(format: "%0\(length)p", intValue)
    }
//    MemoryAddress(of: classInstance)
    // for structures
    init(of structPointer: UnsafePointer<T>) {
        intValue = Int(bitPattern: structPointer)
    }
}

public extension MemoryAddress where T: AnyObject {
//    let structInstanceAddress = MemoryAddress(of: &structInstance)
    // for classes
    init(of classInstance: T) {
        intValue = unsafeBitCast(classInstance, to: Int.self)
        // or      Int(bitPattern: Unmanaged<T>.passUnretained(classInstance).toOpaque())
    }
}
