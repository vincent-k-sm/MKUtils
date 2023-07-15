import Foundation

public extension Data {
    func getSize(type: ByteCountFormatter.Units = [.useMB]) -> String {
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = type
        bcf.countStyle = .file
        let string = bcf.string(fromByteCount: Int64(self.count))
        return string

    }
}

public extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
