// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MySettingsPackage",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "MySettingsPackage",
            targets: ["MySettingsPackage"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "MySettingsPackage",
            dependencies: []),
        .testTarget(
            name: "MySettingsPackageTests",
            dependencies: ["MySettingsPackage"]),
    ]
)
