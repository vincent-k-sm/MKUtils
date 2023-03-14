// swiftlint:disable all
import Foundation

// An object representing the filesystem structure. Allows you to grab references to folders in the filesystem without having to pass them through as environment variables.
class FileStructure {
    
    var rootURL: URL
    var lprojURL: URL
    
    init(sourceRootURL: String? = nil) throws {
        // Grab the parent folder of this file on the filesystem
        let parentFolderOfScriptFile = FileFinder.findParentFolder()
        CodegenLogger.log("Parent folder of script file: \(parentFolderOfScriptFile)")

        // Use that to calculate the source root for both your main project and this codegen project.
        if let sourceRootURL = sourceRootURL {
            if #available(macOS 13.0, *) {
                self.rootURL = URL(filePath: sourceRootURL, directoryHint: .isDirectory)
            }
            else {
                // Fallback on earlier versions
                self.rootURL = URL(fileURLWithPath: sourceRootURL)
            }
        }
        else {
            self.rootURL = parentFolderOfScriptFile
        }
        

        // Set up the folder where you want the typescript CLI to download.
        self.lprojURL = self.rootURL
//          .childFolderURL(folderName: "Sources")
//          .childFolderURL(folderName: "LocalizeKit")
    }
    
//    func configure(
//        targetPackage: String,
//        packageDirName: String? = nil
//    ) {
//        self.constantKitSourceURL = sourceRootURL
//            .childFolderURL(folderName: targetPackage)
//            .childFolderURL(folderName: "Sources")
//            .childFolderURL(folderName: packageDirName ?? targetPackage)
//    }
    
    func configure(targetPath: String) {
        if #available(macOS 13.0, *) {
            self.rootURL = URL(filePath: targetPath, directoryHint: .isDirectory)
            self.lprojURL = URL(filePath: targetPath, directoryHint: .isDirectory)
        }
        else {
            // Fallback on earlier versions
            self.rootURL = URL(fileURLWithPath: targetPath)
            self.lprojURL = URL(fileURLWithPath: targetPath)
        }
    }
}

extension FileStructure: CustomDebugStringConvertible {
    var debugDescription: String {
        """
        Source root URL: \(self.rootURL)
        lprojURL Source URL: \(self.lprojURL)
        """
    }
}
