//
//  File.swift
//

import Foundation
import os.log

public class Log {
    
    private init() {
        
    }
    
    deinit {
        
    }
    
    private static let shared = Log()
    public static var logEnable: Bool = false
    // MARK: 과도한 로그 출력을 조정합니다
    private static let enableLogTypes: [LoggerType] = LoggerType.allCases
//        .filter({ $0 != .event })
//        .filter({ $0 != .auth })
    
    class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
    
    class func sdkprint(logType: LoggerType? = nil, _ object: Any..., filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function, logEvent: LoggerLevels = LoggerLevels.v) {
        if let logType = logType {
            if !Self.enableLogTypes.contains(logType) {
                return
            }
        }
        
        if Log.logEnable {
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss.SSSS"
            let timestamp = formatter.string(from: date)
            
            var filename: NSString = filename as NSString
            filename = filename.lastPathComponent as NSString
            
//            var prefixIcon: String = ""
            let logTitle: String
            if let logType = logType {
                logTitle = "[\(OSLog.subsystem)\(logType.prefix)] [\(timestamp)] [\(filename):\(line) | \(funcName)] | "
            }
            else {
                logTitle = "[\(OSLog.subsystem)] [\(timestamp)] [\(filename):\(line)] | ⚙️ Function: \(funcName) -> \(logEvent.rawValue)\n"
            }
             
            let res: String = _output(printer: _printDebug, object, separator: "\n")
            let logMessage = "\(logTitle)\(res)"
            let osLog: OSLog = logType?.log ?? LoggerType.debug.log
            if #available(iOS 14.0, *) {
                let logger = Logger(osLog)
                switch logEvent {
                    case .v:
                        logger.log(level: .debug, "\(res)")

                    case .d:
                        logger.debug("\(logMessage, privacy: .public)")

                    case .i:
                        logger.info("\(logMessage, privacy: .public)")

                    case .w:
                        logger.warning("\(logMessage, privacy: .public)")

                    case .e:
                        logger.error("\(logMessage, privacy: .public)")
                        
                }
            }
            else {
                var osLogType: OSLogType = .default
                switch logEvent {
                    case .v:
                        osLogType = .default

                    case .d:
                        osLogType = .debug

                    case .i:
                        osLogType = .info

                    case .w:
                        osLogType = .info

                    case .e:
                        osLogType = .error
                }
                os_log("%{public}@", log: osLog, type: osLogType, logMessage)
            }
      
        }
    }
    
    public class func v(logType: LoggerType? = nil, _ object: Any..., filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        sdkprint(logType: logType, object, filename: filename, line: line, column: column, funcName: funcName, logEvent: .d)
    }
    
    public class func d(logType: LoggerType? = nil, _ object: Any..., filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        sdkprint(logType: logType, object, filename: filename, line: line, column: column, funcName: funcName, logEvent: .d)
    }
    
    public class func i(logType: LoggerType? = nil, _ object: Any..., filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        sdkprint(logType: logType, object, filename: filename, line: line, column: column, funcName: funcName, logEvent: .i)
    }
    
    public class func w(logType: LoggerType? = nil, _ object: Any..., filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        sdkprint(logType: logType, object, filename: filename, line: line, column: column, funcName: funcName, logEvent: .w)
    }
    
    public class func e(logType: LoggerType? = nil, _ object: Any..., filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        sdkprint(logType: logType, object, filename: filename, line: line, column: column, funcName: funcName, logEvent: .e)
    }
}

extension Data {
    var prettyJson: String? {
        if self.isEmpty {
            return nil
        }
        do {
            let json = try JSONSerialization.jsonObject(with: self, options: [])
            let data = try JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted, .withoutEscapingSlashes])
            guard let jsonString = String(data: data, encoding: .utf8) else {
//                KILog.e("Json Parsable Error")
                return nil
            }
            return jsonString
        }
        catch {
//            KILog.e("Json Parsable Error: \(error.localizedDescription)")
            return nil
        }
    }
}

extension Log {
    private static func _printDebug(
        _ targets: [Any],
        separator: String,
        colored: Bool
    ) -> String {
        targets.map {
            PrettyDescriber.line(indent: 2).string($0, debug: true)
        }.joined(separator: separator)
    }
    
    private typealias Printer = ([Any], String, Bool) -> String
    private static func _output(
        printer: Printer,
        _ targets: [Any],
        separator: String
    ) -> String {
        let plain = printer(targets, separator, false)
        return plain
    }
}
