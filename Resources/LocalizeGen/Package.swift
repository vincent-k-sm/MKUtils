// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Localizing",
    platforms: [
        .macOS(.v10_14)
    ],
    dependencies: [
        // The official Swift argument parser.
//        .package(
//            url: "https://github.com/apple/swift-argument-parser.git",
//            .upToNextMajor(from: Version(1, 0, 0))
//        )
        .package(path: "./Sources/swift-argument-parser-1.2.2")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Localizing",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser-1.2.2")
            ]
        )
        
        
    ]
)
