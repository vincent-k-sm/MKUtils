//
//  Debug.swift
//  
//
//  Created by vincent on 2023/02/06.
//

import Foundation

public extension Debug {
    struct DebugOption {
        var prefix: String?
        var ignoreDeinit: Bool = false
        var indent: Int = 2
    }
}

public class Debug {
    public static var options: DebugOption = .init()
    public static func configure(options: DebugOption) {
        Debug.options = options
    }
}

// MARK: Standard API
public extension Debug {
    static func print(
        module: String? = nil,
        _ targets: Any...,
        separator: String = "\n",
        option: DebugOption = Debug.options,
        file: String = #file,
        line: Int = #line,
        function: String = #function,
        target: Any? = nil
    ) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSSS"
        let timestamp = formatter.string(from: date)
        
        var filename: NSString = file as NSString
        filename = filename.lastPathComponent as NSString
        
        var prefixIcon: String = ""
        
        var logTitle: String = ""
        if let prefix = option.prefix {
            logTitle = "[\(prefix)] "
        }
        
        if let module = module {
            logTitle += logTitle.isEmpty
            ? "[\(module)]"
            : " [\(module)]"
        }
       
        var isDeinitPrint: Bool = false
        if function.lowercased().contains("deinit") {
            if option.ignoreDeinit {
                return
            }
            else {
                isDeinitPrint = true
                prefixIcon = "🟢"
                logTitle += "[\(filename)] -- deinit | ⏱ TimeStamp: \(timestamp)"
            }
        }
        else {
            prefixIcon = "📌"
            logTitle += "[\(filename)](\(line)) | ⚙️ Function: \(function) | ⏱ TimeStamp: \(timestamp)"
        }
        Swift.print("\n————————————————————————————")
        
        let titleString: String = "\(prefixIcon) \(logTitle)"
        Swift.print(titleString)
        
        if !isDeinitPrint {
            _output(printer: _printDebug, targets, separator: separator, option: option)
        }
        
    }
    
    
}

extension Debug {
    private static func _printDebug(
        _ targets: [Any],
        separator: String,
        option: DebugOption,
        colored: Bool
    ) -> String {
        targets.map {
            PrettyDescriber.line(indent: option.indent).string($0, debug: true)
        }.joined(separator: separator)
    }
    
    private typealias Printer = ([Any], String, DebugOption, Bool) -> String
    
    private static func _output(
        printer: Printer,
        _ targets: [Any],
        separator: String,
        option: DebugOption
    ) {
        let plain = printer(targets, separator, option, false)
        Swift.print(plain)
    }
    
}

extension PrettyDescriber {
    static func line(indent: Int) -> PrettyDescriber {
        return PrettyDescriber(formatter: MultilineFormatter(indentSize: indent))
    }
}
