//
//  File.swift
//
        
import Foundation

/// - info: Log type info
/// - debug: Log type debug
/// - warning: Log type warning
/// - error: Log type error
enum LoggerLevels: String {
    case v = "📌 Verbose" // verbose
    case d = "🧷 Debug" // debug
    case i = "ℹ️ Info" // info
    case w = "🟡 Warning" // warning
    case e = "🔴 Error" // error
    
    var logLevel: Int {
        switch self {
            case .v:
                return 0

            case .d:
                return 1

            case .i:
                return 2

            case .w:
                return 3

            case .e:
                return 4
        }
    }
    
    func isLoggable(_ config: Self) -> Bool {
        return self.rawValue <= config.rawValue
    }
}
