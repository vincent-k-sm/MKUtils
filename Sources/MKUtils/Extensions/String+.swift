import Foundation

public extension String {
    func contactFormatted() -> String {
        let localNumberArray: [String] = ["02", "031", "032", "033", "041", "042", "043", "044", "051", "052", "054", "053", "054", "055", "061", "062", "063", "064", "070", "080", "050", "010", "011", "012", "015", "016", "017", "018", "019", "030"]
        var validCount = 0
        
        let textValue = self.replacingOccurrences(of: "-", with: "")

        var textValueArray: [String] = textValue.map { String($0) }
        
        if localNumberArray.contains(String(textValue.prefix(2))) {
            // 02
            if textValue.count > 8 {
                
                if textValue.count >= 10 {
                    // 지우는 경우
                    textValueArray.insert("-", at: 6)
                }
                else {
                    // 작성중인 경우
                    textValueArray.insert("-", at: 5)
                }
            }
            else if textValue.count > 5 {
                textValueArray.insert("-", at: 5)
            }
            
            // 02 다음에 끼워넣기
            if textValue.count > 2 {
                textValueArray.insert("-", at: 2)
            }
            validCount = 10
            
        }
        else if localNumberArray.contains(String(textValue.prefix(3))) {
            // 031 등
            if textValue.count > 8 {
                if textValue.count >= 11 {
                    // 지우는 경우
                    textValueArray.insert("-", at: 7)
                }
                else {
                    // 작성중인 경우
                    textValueArray.insert("-", at: 6)
                }
                
            }
            else if textValue.count > 6 {
                textValueArray.insert("-", at: 6)
            }
            
            if textValue.count > 3 {
                textValueArray.insert("-", at: 3)
            }
            
            validCount = 11
            
        }
        else {
            // 1588
            if textValue.count > 4 {
                textValueArray.insert("-", at: 4)
            }
            validCount = 8
        }
        
        if textValue.count > validCount {
            textValueArray = textValueArray.dropLast()
        }
        
        return textValueArray.joined()
    }
    
    func toBool() -> Bool {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0", "":
            return false

        default:
            return false
        }
    }
    
}

// MARK: static
extension String {
    
    // random
    static func random(length: Int = 20) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""
        
        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
    
    func toInt() -> Int {
        let newString = self.replacingOccurrences(of: ".", with: "")
        let value: Int = Int(newString) ?? 0
        
        return value
        
    }
    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            }
            catch {
                Debug.print(error.localizedDescription)
            }
        }
        return nil
    }

}

extension String {
    func containsEmoji() -> Bool {
        for scalar in unicodeScalars {
            
            switch scalar.value {
                case 0x3030, 0x00AE, 0x00A9: // Special Characters
                    return true
                case 0x1D000...0x1F77F:          // Emoticons
                    return true
                case 0x2100...0x27BF:            // Misc symbols and Dingbats
                    return true
                case 0xFE00...0xFE0F:            // Variation Selectors
                    return true
                case 0x1F900...0x1F9FF:          // Supplemental Symbols and Pictographs
                    return true

            default:
                continue
            }
        }
        return false
    }
}

extension String {
    var isNotEmpty: Bool {
        get {
            return !self.isEmpty
        }
    }

}
