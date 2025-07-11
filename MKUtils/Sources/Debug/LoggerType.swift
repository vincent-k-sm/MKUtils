//
//  File.swift
//
        
import Foundation
import os.log

public enum LoggerType: String, CaseIterable {
    case debug
    
    var log: OSLog {
        return OSLog(subsystem: OSLog.subsystem, category: self.rawValue)
    }
    
    var prefix: String {
        return ".\(self.rawValue)"
    }
}

extension OSLog {
    static let subsystem = "LOG"
}
