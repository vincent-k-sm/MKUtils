// swiftlint:disable all

//
//  FileFinder.swift
//
import Foundation

public struct FileFinder {
    
#if compiler(>=5.3)
    /// Version that works if you're using the 5.3 compiler or above
    /// - Parameter filePath: The full file path of the file to find. Defaults to the `#filePath` of the caller.
    /// - Returns: The file URL for the parent folder.
    public static func findParentFolder(from filePath: StaticString = #filePath) -> URL {
        self.findParentFolder(from: filePath.toString)
    }
    
    /// The URL of a file at a given path
    /// - Parameter filePath: The full file path of the file to find
    /// - Returns: The file's URL
    public static func fileURL(from filePath: StaticString = #filePath) -> URL {
        URL(fileURLWithPath: filePath.toString)
    }
#else
    /// Version that works if you're using the 5.2 compiler or below
    /// - Parameter file: The full file path of the file to find. Defaults to the `#file` of the caller.
    /// - Returns: The file URL for the parent folder.
    public static func findParentFolder(from filePath: StaticString = #file) -> URL {
        self.findParentFolder(from: filePath.toString)
    }
    
    /// The URL of a file at a given path
    /// - Parameter filePath: The full file path of the file to find
    /// - Returns: The file's URL
    public static func fileURL(from filePath: StaticString = #file) -> URL {
        URL(fileURLWithPath: filePath.toString)
    }
#endif
    
    /// Finds the parent folder from a given file path.
    /// - Parameter filePath: The full file path, as a string
    /// - Returns: The file URL for the parent folder.
    public static func findParentFolder(from filePath: String) -> URL {
        let url = URL(fileURLWithPath: filePath)
        return url.deletingLastPathComponent()
    }
}

extension URL {
    var isDirectoryURL: Bool {
        guard
            let resourceValues = try? self.resourceValues(forKeys: [.isDirectoryKey]),
            let isDirectory = resourceValues.isDirectory else {
            return false
        }
        
        return isDirectory
    }
    
    var isSwiftFileURL: Bool {
        self.pathExtension == "swift"
    }
    
    /// - Returns: the URL to the parent folder of the current URL.
    public func parentFolderURL() -> URL {
        self.deletingLastPathComponent()
    }
    
    /// - Parameter folderName: The name of the child folder to append to the current URL
    /// - Returns: The full URL including the appended child folder.
    public func childFolderURL(folderName: String) -> URL {
        self.appendingPathComponent(folderName, isDirectory: true)
    }
    
    /// Adds the filename to the caller to get the full URL of a file
    ///
    /// - Parameters:
    ///   - fileName: The name of the child file, with an extension, for example `"API.swift"`. Note: For hidden files just pass `".filename"`.
    /// - Returns: The full URL including the full file.
    public func childFileURL(fileName: String) throws -> URL {
        guard !fileName.isEmpty else {
            throw URLError.fileNameIsEmpty
        }
        
        return self.appendingPathComponent(fileName, isDirectory: false)
    }
}

extension StaticString {
    var lastPathComponent: String {
        return (toString as NSString).lastPathComponent
    }
    
    var toString: String {
        return self.withUTF8Buffer {
            String(decoding: $0, as: UTF8.self)
        }
    }
}

extension Collection {
    var isNotEmpty: Bool {
        return !self.isEmpty
    }
}

public enum URLError: Error, LocalizedError {
    case fileNameIsEmpty
    
    public var errorDescription: String? {
        switch self {
            case .fileNameIsEmpty:
                return "The file name for this file URL was empty. Please pass a non-empty string."
        }
    }
}
