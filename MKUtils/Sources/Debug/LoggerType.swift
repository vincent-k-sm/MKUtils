//
//  File.swift
//
        
import Foundation
import os.log

public enum LoggerType {
    public init?(rawValue: String) {
        switch rawValue {
            case "info":
                self = .info
                
            case "debug":
                self = .debug
                
            default:
                self = .custom(rawValue)
        }
    }
    
    public var rawValue: String {
        
        switch self {
            case .debug:
                return "debug"
                
            case .info:
                return "info"
                
            case .custom(let string):
                return string
        }
    }
    
    public typealias RawValue = String

    case debug
    case info
    case custom(String)
    
    var log: OSLog {
        return OSLog(subsystem: OSLog.subsystem, category: self.rawValue)
        
    }
    
    var prefix: String {
        return ".\(self.rawValue)"
    }
}

extension OSLog {
    static let subsystem = Bundle.main.bundleIdentifier!
}
