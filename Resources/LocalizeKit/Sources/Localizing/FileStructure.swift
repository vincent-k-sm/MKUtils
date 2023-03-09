// swiftlint:disable all
import Foundation

// An object representing the filesystem structure. Allows you to grab references to folders in the filesystem without having to pass them through as environment variables.
class FileStructure {
    
    var sourceRootURL: URL
    var constantKitSourceURL: URL
    
    init(sourceRootURL: String? = nil) throws {
        // Grab the parent folder of this file on the filesystem
        let parentFolderOfScriptFile = FileFinder.findParentFolder()
        CodegenLogger.log("Parent folder of script file: \(parentFolderOfScriptFile)")

        // Use that to calculate the source root for both your main project and this codegen project.
        // NOTE: You may need to change this if your project has a different structure than the suggested st/Users/vincent/Desktop/PersonalProject/MKUtils/Resources/LocalizeKit/RunLocalizingructure.
        if let sourceRootURL = sourceRootURL {
            if #available(macOS 13.0, *) {
                self.sourceRootURL = URL(filePath: sourceRootURL, directoryHint: .isDirectory)
            }
            else {
                // Fallback on earlier versions
                self.sourceRootURL = URL(fileURLWithPath: sourceRootURL)
            }
        }
        else {
            self.sourceRootURL = parentFolderOfScriptFile
              .parentFolderURL() // Result: Sources folder
              .parentFolderURL() // Result: Package Folder
              .parentFolderURL() // Result: Root of Packages Folder
        }
        

        // Set up the folder where you want the typescript CLI to download.
        self.constantKitSourceURL = self.sourceRootURL
//          .childFolderURL(folderName: "Sources")
//          .childFolderURL(folderName: "LocalizeKit")
    }
    
    func configure(
        targetPackage: String,
        packageDirName: String? = nil
    ) {
        self.constantKitSourceURL = sourceRootURL
            .childFolderURL(folderName: targetPackage)
            .childFolderURL(folderName: "Sources")
            .childFolderURL(folderName: packageDirName ?? targetPackage)
    }
}

extension FileStructure: CustomDebugStringConvertible {
    var debugDescription: String {
        """
        Source root URL: \(self.sourceRootURL)
        ConstantKit Source URL: \(self.constantKitSourceURL)
        """
    }
}
