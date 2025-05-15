// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Toast",
    defaultLocalization: "en",
    platforms: [.iOS(.v16), .macOS(.v14)],
    products: [
        .library(
            name: "Toast",
            targets: ["Toast"]),
    ],
    targets: [
        .target(
            name: "Toast"),
    ]
)
