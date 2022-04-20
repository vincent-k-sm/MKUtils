#if canImport(UIKit)
import UIKit

public extension UIImage {
    class func colorForNavBar(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)  // height = 라인두께
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context!.setFillColor(color.cgColor)
        context!.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image!
    }
    
    func resizeImage(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

public extension UIImage {

    enum CompressImageErrors: Error {
        case invalidExSize
        case sizeImpossibleToReach
    }
    
    /// Get Expect Compress Quaility
    /// - Parameters:
    ///   - expectedSizeKb: 250KB
    ///   - completion: UIImage, Compress Quaility
    ///   - Usaage
    ///         try? image.compressImageTo(250, completion: { (image, compressRatio) in
    ///             data = image.jpegData(compressionQuality: compressRatio)
    ///         })
    func compressImageTo(_ expectedSizeKb: Int, maxImageResizeWidth: Int, completion: (UIImage, CGFloat) -> Void ) throws {

        let minimalCompressRate: CGFloat = 0.4 // min compressRate to be checked later

        if expectedSizeKb == 0 {
            throw CompressImageErrors.invalidExSize // if the size is equal to zero throws
        }

        let expectedSizeBytes = expectedSizeKb * 1024
        let imageToBeHandled: UIImage = self
        var actualHeight: CGFloat = self.size.height
        var actualWidth: CGFloat = self.size.width
        var maxHeight: CGFloat = CGFloat(maxImageResizeWidth)
        var maxWidth: CGFloat = CGFloat(maxImageResizeWidth)
        var imgRatio: CGFloat = actualWidth/actualHeight
        let maxRatio: CGFloat = maxWidth/maxHeight
        var compressionQuality: CGFloat = 1
        var imageData: Data = imageToBeHandled.jpegData(compressionQuality: compressionQuality)!
        while imageData.count > expectedSizeBytes {

            if actualHeight > maxHeight || actualWidth > maxWidth {
                if imgRatio < maxRatio {
                    imgRatio = maxHeight / actualHeight
                    actualWidth = imgRatio * actualWidth
                    actualHeight = maxHeight
                }
                else if imgRatio > maxRatio {
                    imgRatio = maxWidth / actualWidth
                    actualHeight = imgRatio * actualHeight
                    actualWidth = maxWidth
                }
                else {
                    actualHeight = maxHeight
                    actualWidth = maxWidth
                    compressionQuality = 1
                }
            }
            let rect = CGRect(x: 0.0, y: 0.0, width: actualWidth, height: actualHeight)
            UIGraphicsBeginImageContext(rect.size)
            imageToBeHandled.draw(in: rect)
            let img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            if let imgData = img!.jpegData(compressionQuality: compressionQuality) {
                if imgData.count > expectedSizeBytes {
                    if compressionQuality > minimalCompressRate {
                        compressionQuality -= 0.1
                    }
                    else {
                        maxHeight = maxHeight * 0.9
                        maxWidth = maxWidth * 0.9
                    }
                }
                imageData = imgData
            }

        }

        completion(UIImage(data: imageData)!, compressionQuality)
    }

}

#endif

