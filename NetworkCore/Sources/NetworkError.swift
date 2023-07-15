//
//  NetworkError.swift
//
        

import Foundation

public struct NetworkErrorInfo: Error {
    public var requestURL: String
    public var errorCode: Int
    public var debugMessage: String
    public var message: String
    
    public init(requestURL: String, errorCode: Int, debugMessage: String, message: String) {
        self.requestURL = requestURL
        self.errorCode = errorCode
        self.debugMessage = debugMessage
        self.message = message
    }
}

extension NetworkErrorInfo: LocalizedError {
    
    public var debugDescription: String {
        return NSLocalizedString(
            self.debugMessage,
            comment: ""
        )
    }
    
    public var errorDescription: String? {
        return NSLocalizedString(
            self.message,
            comment: ""
        )
    }
}
