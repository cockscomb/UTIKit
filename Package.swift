// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UTIKit",
    products: [
        .library(name: "UTIKit", targets: ["UTIKit"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "UTIKit", dependencies: [], path: "UTIKit", exclude: ["Info.plist"])
    ]
)
