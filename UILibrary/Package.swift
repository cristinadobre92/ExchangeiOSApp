// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UILibrary",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "UILibrary",
            targets: ["UILibrary"]),
    ],
    dependencies: [
        .package(path: "../NetworkLibrary")
    ],
    targets: [
        .target(
            name: "UILibrary",
            dependencies: [
                .product(name: "NetworkLibrary", package: "NetworkLibrary")
            ]
        ),
    ]
)
