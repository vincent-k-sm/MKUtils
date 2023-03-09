// swiftlint:disable all
import Foundation
import ArgumentParser

// An outer structure to hold all commands and sub-commands handled by this script.

struct SwiftScript: ParsableCommand {

    static var configuration = CommandConfiguration(
        abstract: """
        A swift-based utility for performing Apollo-related tasks.
        
        NOTE: If running from a compiled binary, prefix subcommands with `swift-script`. Otherwise use `swift run generate [subcommand]`.
        """,
        subcommands: [GenerateCode.self]
    )
    
    /// The sub-command to actually generate code.
    struct GenerateCode: ParsableCommand {
//        @Argument(help: "Target Packages Root Path")
//        var root: String
        
        
        @Option(name: .customShort("p"), help: "Target Packages Root Path.")
        var root: String
        
        @Option(name: .customShort("t"), help: "Target Packages")
        var targets: [String] = []
        
        
        static var configuration = CommandConfiguration(
            commandName: "generate",
            abstract: "Generates swift code from your localized.string based on information set up in the `GenerateCode` command.")
        
        func run() throws {
//            let packages: [String] = ["LocalizeKit"] + targets
            let packages: [String] = targets
            CodegenLogger.log("Target Packages:\n\(packages)\n")
            
            let fileStructure = try FileStructure(sourceRootURL: root)
            for target in packages {
                fileStructure.configure(targetPackage: target)
                CodegenLogger.log("File structure:\n\(fileStructure.debugDescription)\n")
                CodegenLogger.log("------------------------------------------")
                CodegenLogger.log("Start localizing for target : \(target)")
                try self.runScript(fileStructure: fileStructure)
                CodegenLogger.log("Finished localizing for target : \(target)")
                CodegenLogger.log("------------------------------------------\n")
            }
            CodegenLogger.log("")
        }
        
        func runScript(fileStructure: FileStructure) throws {
            // Get the root of the target for which you want to generate code.
            // TODO: Replace the placeholder here with the name of of the folder containing your project's code files.
            
            let targetRootURL = fileStructure.constantKitSourceURL
                .childFolderURL(folderName: "Localizable")
            
            try FileManager.default.createFolderIfNeeded(at: targetRootURL)
            
            let stringFileURL = targetRootURL
                .childFolderURL(folderName: "ko.lproj")
//            CodegenLogger.log("stringFileURL: \(stringFileURL)")
            
            
            let generator = LocalizingGenerator(binaryFolderURL: targetRootURL)
            try generator.runI18N(from: stringFileURL)
        
            
            let outputFileURL = try stringFileURL.childFileURL(fileName: "I18N.swift")
//            CodegenLogger.log("outputFileURL: \(outputFileURL)")
            
            let destinationFileURL = try fileStructure.constantKitSourceURL
                .childFolderURL(folderName: "Localizable")
                .childFileURL(fileName: "I18N.swift")
            
//            CodegenLogger.log("destinationFileURL: \(destinationFileURL.absoluteString)")
            
            do {
                if FileManager.default.fileExists(at: destinationFileURL.path) {
                    try FileManager.default.removeItem(at: destinationFileURL)
                }
                
                try FileManager.default.copyItem(at: outputFileURL, to: destinationFileURL)
                try FileManager.default.removeItem(at: outputFileURL)
            }
            catch let error {
                CodegenLogger.log(error.localizedDescription, logLevel: .error)
                throw error
            }
            
            
            
        }
    }

}

// This will set up the command and parse the arguments when this executable is run.
SwiftScript.main()
