import Photos

@available(macOS 10.13, *)
public extension PHAsset {
    @available(macOS 10.15, *)
    var assetFileSizeMB: Float {
        get {
            let resources = PHAssetResource.assetResources(for: self) // your PHAsset
            
            var sizeOnDisk: Int64? = 0

            if let resource = resources.first {
                let unsignedInt64 = resource.value(forKey: "fileSize") as? CLong
                sizeOnDisk = Int64(bitPattern: UInt64(unsignedInt64!))
            }
            if let byte = Int(exactly: sizeOnDisk ?? 0) {
                let float = Float(byte) / 1024 / 1024
                return float
            }
            else {
                return 0.0
            }

//            let kb = self.converByteToHumanReadable(sizeOnDisk ?? 0)
//            let float = Float(NSString(string: kb).floatValue)
//            return float

        }
        
    }
    
    private func converByteToHumanReadable(_ bytes: Int64) -> String {
        
        let formatter: ByteCountFormatter = ByteCountFormatter()
        formatter.countStyle = .binary

        return formatter.string(fromByteCount: Int64(bytes))
    }
}
