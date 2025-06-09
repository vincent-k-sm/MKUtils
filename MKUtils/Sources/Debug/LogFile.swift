//
//  File.swift
//

import Foundation

class LogFile {
    
    static let shared: LogFile = .init()
    
    private init() { }
    
    private(set) var fileName: String = ""
    
    var logFilePath: URL? {
        if self.fileName.isEmpty {
            return nil
        }
        let fileManager = FileManager.default
        if let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            return documentsDirectory.appendingPathComponent(self.fileName)
        }
        return nil
    }
    
    private var header: String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSSS"
        let timestamp = formatter.string(from: date)
        
        var currentVersion: String = ""
        if let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") {
            currentVersion = "\(appVersion)"
        }
        var currentBuildVersion: String = ""
        if let buildNum = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) {
            currentBuildVersion = "\(buildNum)"
        }

        return "\n[\(timestamp)] App Launched \(currentVersion)(\(currentBuildVersion))"
    }
    
    internal func setupFileName(name: String) {
        self.fileName = name + ".log"
        self.writeLogToFile(content: self.header)
    }
    
    internal func clearLogFile(completion: @escaping () -> Void) {
        let fileManager = FileManager.default
        if let logFileURL = self.logFilePath {
            if fileManager.fileExists(atPath: logFileURL.path) {
                do {
                    // 빈 문자열로 덮어쓰기 (파일 내용을 비움)
                    try self.header.write(to: logFileURL, atomically: true, encoding: .utf8)
                    completion()
//                    print("Log file cleared: \(logFileURL.path)")
                } 
                catch {
//                    print("Error clearing log file: \(error)")
                }
            }
            else {
//                print("Log file does not exist.")
            }
        }
        
    }
    
    internal func getLogFileSize() -> String {
        
        let fileManager = FileManager.default
        if let logFileURL = self.logFilePath {
            if fileManager.fileExists(atPath: logFileURL.path) {
                do {
                    let data: Data = try .init(contentsOf: logFileURL)
                    return data.getReadableUnit()
                    
                }
                catch {
//                    print("Error clearing log file: \(error)")
                }
            }
            else {
//                print("Log file does not exist.")
            }
        }
            
        return "-"
    }
    
    internal func writeLogToFile(content: String) {
        if self.fileName.isEmpty {
            return
        }
        
        // 파일 경로 지정 (Documents 디렉토리)
        let fileManager = FileManager.default
        if let logFileURL = self.logFilePath {
            // 파일이 이미 존재하는지 확인
            if !fileManager.fileExists(atPath: logFileURL.path) {
                // 파일이 없으면 생성
                do {
                    try (content + "\n").write(to: logFileURL, atomically: true, encoding: .utf8)
//                    print("Log file created at: \(logFileURL.path)")
                }
                catch {
//                    print("Error creating log file: \(error)")
                }
            }
            else {
                // 파일이 있으면 기존 파일에 추가
                if let fileHandle = FileHandle(forWritingAtPath: logFileURL.path) {
                    fileHandle.seekToEndOfFile() // 파일 끝으로 포인터 이동
                    if let data = content.data(using: .utf8) {
                        fileHandle.write(data) // 데이터 추가
//                        print("Log file updated at: \(logFileURL.path)")
                    }
                    fileHandle.closeFile()
                }
            }
        }
    }
    
    deinit {
        //
    }
}

public enum LogSizeType {
    case byte
    case kb
    case mb
    case gb
}

extension Data {

    var bytes: Int64 {
        .init(self.count)
    }

    public var kilobytes: Double {
        return Double(bytes) / 1_024
    }

    public var megabytes: Double {
        return kilobytes / 1_024
    }

    public var gigabytes: Double {
        return megabytes / 1_024
    }

    public func getReadableUnit() -> String {

        switch bytes {
//            case 0..<1_024:
//                return "\(bytes) bytes"
//            case 1_024..<(1_024 * 1_024):
            case 0..<(1_024 * 1_024):
                return "\(String(format: "%.2f", kilobytes)) KB"
            case 1_024..<(1_024 * 1_024 * 1_024):
                return "\(String(format: "%.2f", megabytes)) MB"
            case (1_024 * 1_024 * 1_024)...Int64.max:
                return "\(String(format: "%.2f", gigabytes)) GB"
            default:
                return "\(bytes) bytes"
        }
    }
}
