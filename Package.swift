// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "vragen-cli",
    platforms: [
       .macOS(.v10_15),
    ],
    products: [
        .executable(name: "vragen", targets: ["Run"]),
        .library(name: "vragen-cli", targets: ["App"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMinor(from: "0.3.0")),
        .package(url: "https://github.com/MartinMetselaar/vragen-sdk-network.git", from: "1.3.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(name: "App", dependencies: [
            .product(name: "VragenSDKNetwork", package: "vragen-sdk-network"),
            .product(name: "ArgumentParser", package: "swift-argument-parser"),
        ]),
        .target(name: "Run", dependencies: [
            .target(name: "App"),
        ]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
        ])
    ]
)
