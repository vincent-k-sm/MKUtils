//
//  MultilineFormatter.swift
//  
//
//  Created by vincent on 2023/02/06.
//

import Foundation

class MultilineFormatter: PrettyFormatter {
    
    private let indentSize: Int
    
    init(indentSize: Int) {
        self.indentSize = indentSize
    }
    
    func collectionString(elements: [String]) -> String {
        let contents = elements.joined(separator: ",\n")
        
        return """
        [
        \(contents.indent(size: indentSize))
        ]
        """
    }
    
    func dictionaryString(keysAndValues: [(String, String)]) -> String {
        let lines = keysAndValues.map { key, value in
            "\(key): \(value)"
        }.sorted()
        
        let contents = lines.joined(separator: ",\n")
        
        return """
        [
        \(contents.indent(size: indentSize))
        ]
        """
    }
    
    func tupleString(elements: [(String?, String)]) -> String {
        let lines: [String] = elements.map { label, value in
            if let label = label {
                return "\(label): \(value)"
            }
            else {
                return value
            }
        }
        
        let contents = lines.joined(separator: ",\n")
        
        return """
        (
        \(contents.indent(size: indentSize))
        )
        """
    }
    
    /// NOTE:
    /// transform fields to single string
    /// insert indent according to key
    ///
    /// ex:
    /// ("owner", """
    /// Owner(name: "Nanachi",
    ///       age: 4)
    /// """)
    ///
    /// goes to
    ///
    /// owner: Owner(
    ///            name: "Nanachi",
    ///            age: 4)
    ///        )
    ///
    func objectString(
        typeName: String, fields: [(String, String)]
    ) -> String {
        if fields.count == 1, let field = fields.first {
            return "typeName(" + "\(field.0): \(field.1)" + ")"
        }
        else {
            let body = fields
                .map { label, value in "\(label): \(value)" }
                .joined(separator: ",\n")
                .indent(size: indentSize)
            
            return """
            \(typeName)(
            \(body)
            )
            """
        }
    }
}

extension String {
    var lines: [String] {
        split(separator: "\n").map(String.init)
    }
    
    func indent(size: Int) -> String {
        lines
            .map { String(repeating: " ", count: size) + $0 }
            .joined(separator: "\n")
    }
    
    func indentTail(size: Int) -> String {
        guard let head = lines.first else { return self }
        return ([head] + lines.dropFirst().map { $0.indent(size: size) })
            .joined(separator: "\n")
    }
    
    func removeEnclosedParentheses() -> String {
        var s = self
        if first == "(", last == ")" {
            s.removeFirst()
            s.removeLast()
        }
        return s
    }
}
