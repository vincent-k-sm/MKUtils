//
//  Dictionary+.swift
//

import Foundation

public extension Dictionary {
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@",
                              // ! optional unwrapping [ ]
                              String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                              // ! optional unwrapping [ ]
                              String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
    
    var urlQueryItems: [URLQueryItem]? {
        let queryItems = self.map { (key, value) in
            URLQueryItem(name: String(describing: key),
                         value: String(describing: value))
        }
        return queryItems
    }
}


public extension Dictionary where Key == String, Value: Any {
    func toJsonString() -> String? {
        if let data = try? JSONSerialization.data(withJSONObject: self, options: []) {
            return String(data: data, encoding: .utf8)
        }
        else {
            return nil
        }
    }
}
