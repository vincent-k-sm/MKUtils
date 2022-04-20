#if canImport(os)
import os.log
#endif

#if canImport(Foundation)
import Foundation
#endif
// swiftlint:disable all
public class Debug {
    /// Global format option
    static var sharedOption: Option = .init()
    
    static var plainLogStream = LogOutputStream(url: URL(fileURLWithPath: "/tmp/SwiftPrettyPrint/output.log"))
    static var coloredLogStream = LogOutputStream(url: URL(fileURLWithPath: "/tmp/SwiftPrettyPrint/output-colored.log"))
    
    private init() {}
    
}

// MARK: Standard API

extension Debug {
    /// Output `targets` to console.
    /// - Parameters:
    ///   - label: label
    ///   - targets: targets
    ///   - separator: A string to print between each item.
    ///   - option: option (default: `Pretty.sharedOption`)
    static func basePrint(
        label: String? = nil,
        _ targets: Any...,
        separator: String = " ",
        option: Option = Debug.sharedOption
    ) {
        _output(printer: _print, label: label, targets, separator: separator, option: option)
    }
    
    /// Output `targets` to `output`.
    /// - Parameters:
    ///   - label: label
    ///   - target: targets
    ///   - separator: A string to print between each item.
    ///   - option: option (default: `Pretty.sharedOption`)
    ///   - colored: whether to apply the color theme in `option`.
    ///   - output: output
    static func basePrint<Target: TextOutputStream>(
        label: String? = nil,
        _ targets: Any...,
        separator: String = " ",
        option: Option = Debug.sharedOption,
        colored: Bool = false,
        to output: inout Target
    ) {
        let plain = _print(label: label, targets, separator: separator, option: option, colored: colored)
        Swift.print(plain, to: &output)
    }
    
    /// Output pretty-formatted `targets` to console.
    /// - Parameters:
    ///   - label: label
    ///   - targets: targets
    ///   - separator: A string to print between each item.
    ///   - option: option (default: `Pretty.sharedOption`)
    static func print(
        //        label: String? = nil,
        _ targets: Any...,
        separator: String = "\n",
        option: Option = Debug.sharedOption,
        file: String = #file,
        line: Int = #line,
        function: String = #function,
        target: Any? = nil,
        simple: Bool = false
    ) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSSS"
        let timestamp = formatter.string(from: date)
        
        var filename: NSString = file as NSString
        filename = filename.lastPathComponent as NSString
        
        if function.contains("deinit") && option.ignoreDeinit { return }
        Swift.print("\n————————————————————————————")
        let title = "|📌 [\(filename)](\(line)) | ⚙️ Function: \(function) | ⏱ TimeStamp: \(timestamp) "
        Swift.print(title)
        //        if function.contains("deinit") { return }
        //        _output(printer: _prettyPrint, label: label, targets, separator: separator, option: option)
        
        if simple {
            //			_output(printer: _printDebug, label: label, targets, separator: " ", option: option)
            _output(printer: _printDebug, label: nil, targets, separator: " ", option: option)
        }
        else {
            //			Swift.print("| ⏺")
            //			_output(printer: _prettyPrintDebug, label: label, targets, separator: separator, option: option)
            _output(printer: _prettyPrintDebug, label: nil, targets, separator: separator, option: option)
            //			Swift.print("| ⏹")
        }
        
        //		Swift.print("| ———————————————————————————— ⏹")
    }
    
    static func simplePrint(
        label: String? = nil,
        _ targets: Any...,
        separator: String = "\n",
        option: Option = Debug.sharedOption,
        file: String = #file,
        line: Int = #line,
        function: String = #function,
        target: Any? = nil,
        simple: Bool = true
    ) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSSS"
        let timestamp = formatter.string(from: date)
        
        var filename: NSString = file as NSString
        filename = filename.lastPathComponent as NSString
        
        Swift.print("\n————————————————————————————")
        let title = "|📌 [\(filename)](\(line)) | ⚙️ Function: \(function) | ⏱ TimeStamp: \(timestamp) "
        Swift.print(title)
        //        _output(printer: _prettyPrint, label: label, targets, separator: separator, option: option)
        
        if simple {
            _output(printer: _printDebug, label: label, targets, separator: " ", option: option)
        }
        else {
            //			Swift.print("| ⏺")
            _output(printer: _prettyPrintDebug, label: label, targets, separator: separator, option: option)
            //			Swift.print("| ⏹")
        }
        
        //		Swift.print("| ———————————————————————————— ⏹")
    }
    
    /// Output pretty-formatted `targets` to console.
    /// - Parameters:
    ///   - label: label
    ///   - targets: targets
    ///   - separator: A string to print between each item.
    ///   - option: option (default: `Pretty.sharedOption`)
    ///   - output: output
    static func prettyPrint<Target: TextOutputStream>(
        label: String? = nil,
        _ targets: Any...,
        separator: String = "\n",
        option: Option = Debug.sharedOption,
        colored: Bool = false,
        to output: inout Target
    ) {
        let plain = _prettyPrint(label: label, targets, separator: separator, option: option, colored: colored)
        Swift.print(plain, to: &output)
    }
    
    /// Output debuggable `targets` to console.
    /// - Parameters:
    ///   - label: label
    ///   - targets: targets
    ///   - separator: A string to print between each item.
    ///   - option: option (default: `Pretty.sharedOption`)
    static func printDebug(
        label: String? = nil,
        _ targets: Any...,
        separator: String = " ",
        option: Option = Debug.sharedOption
    ) {
        _output(printer: _printDebug, label: label, targets, separator: separator, option: option)
    }
    
    /// Output debuggable `targets` to console.
    /// - Parameters:
    ///   - label: label
    ///   - targets: targets
    ///   - separator: A string to print between each item.
    ///   - option: option (default: `Pretty.sharedOption`)
    ///   - output: output
    static func printDebug<Target: TextOutputStream>(
        label: String? = nil,
        _ targets: Any...,
        separator: String = " ",
        option: Option = Debug.sharedOption,
        to output: inout Target
    ) {
        let plain = _printDebug(label: label, targets, separator: separator, option: option, colored: false)
        Swift.print(plain, to: &output)
    }
    
    /// Output debuggable and pretty-formatted `targets` to console.
    /// - Parameters:
    ///   - targets: targets
    ///   - separator: A string to print between each item.
    ///   - option: option (default: `Pretty.sharedOption`)
    static func prettyPrintDebug(
        label: String? = nil,
        _ targets: Any...,
        separator: String = "\n",
        option: Option = Debug.sharedOption
    ) {
        _output(printer: _prettyPrintDebug, label: label, targets, separator: separator, option: option)
    }
    
    /// Output debuggable and pretty-formatted `target` to console.
    /// - Parameters:
    ///   - targets: targets
    ///   - separator: A string to print between each item.
    ///   - option: option (default: `Pretty.sharedOption`)
    ///   - output: output
    static func prettyPrintDebug<Target: TextOutputStream>(
        label: String? = nil,
        _ targets: Any...,
        separator: String = "\n",
        option: Option = Debug.sharedOption,
        to output: inout Target
    ) {
        let plain = _prettyPrintDebug(label: label, targets, separator: separator, option: option, colored: false)
        Swift.print(plain, to: &output)
    }
    
    // MARK: - private
    
    private typealias Printer = (String?, [Any], String, Option, Bool) -> String
    
    private static func _output(
        printer: Printer,
        label: String?,
        _ targets: [Any],
        separator: String,
        option: Option
    ) {
        let plain = printer(label, targets, separator, option, false)
        let colored = printer(label, targets, separator, option, true)
        
        // Console
        if separator == " "{
            // single
            Swift.print("| DEBUG : " + plain)
        }
        else {
            // multi
            Swift.print(plain)
        }
        
        // OS Log
#if canImport(os)
        if option.outputStrategy == .osLog, #available(OSX 10.14, iOS 12.0, *) {
            os_log(.default, "%@", plain)
            return
        }
#endif
        
        // Log files
#if targetEnvironment(simulator) || os(macOS)
        Swift.print(plain + "\n", to: &plainLogStream)
        Swift.print(colored + "\n", to: &coloredLogStream)
#endif
    }
    
    private static func _print(
        label: String?,
        _ targets: [Any],
        separator: String,
        option: Option,
        colored: Bool
    ) -> String {
        prefixLabel(option.prefix, label) +
        targets.map {
            PrettyDescriber.singleline(option: option, colored: colored).string($0, debug: false)
        }.joined(separator: separator)
    }
    
    private static func _prettyPrint(
        label: String?,
        _ targets: [Any],
        separator: String,
        option: Option,
        colored: Bool
    ) -> String {
        prefixLabelPretty(option.prefix, label) +
        targets.map {
            PrettyDescriber.multiline(option: option, colored: colored).string($0, debug: false)
        }.joined(separator: separator)
    }
    
    private static func _printDebug(
        label: String?,
        _ targets: [Any],
        separator: String,
        option: Option,
        colored: Bool
    ) -> String {
        prefixLabel(option.prefix, label) +
        targets.map {
            PrettyDescriber.singleline(option: option, colored: colored).string($0, debug: true)
        }.joined(separator: separator)
    }
    
    private static func _prettyPrintDebug(
        label: String?,
        _ targets: [Any],
        separator: String,
        option: Option,
        colored: Bool
    ) -> String {
        prefixLabelPretty(option.prefix, label) +
        targets.map {
            PrettyDescriber.multiline(option: option, colored: colored).string($0, debug: true)
        }.joined(separator: separator)
    }
}

extension PrettyDescriber {
    static func singleline(option: Debug.Option, colored: Bool) -> PrettyDescriber {
        let theme = colored ? option.theme : .plain
        return PrettyDescriber(formatter: SinglelineFormatter(theme: theme), theme: theme)
    }
    
    static func multiline(option: Debug.Option, colored: Bool) -> PrettyDescriber {
        let theme = colored ? option.theme : .plain
        return PrettyDescriber(formatter: MultilineFormatter(indentSize: option.indentSize, theme: theme), theme: theme)
    }
}
