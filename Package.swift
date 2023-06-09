// swift-tools-version:5.4

import PackageDescription

let package = Package(
    name: "SwiftyProse",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "SwiftyProse",
            targets: ["SwiftyProse"])
    ],
    targets: [
        .target(
            name: "SwiftyProse",
            dependencies: [])
    ],
    swiftLanguageVersions: [.v5]
)
