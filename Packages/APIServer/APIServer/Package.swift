// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "APIServer",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "APIServer",
            targets: ["APIServer"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.76.0")
    ],
    targets: [
        .target(
            name: "APIServer",
            dependencies: [
                .product(name: "Vapor", package: "vapor")
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "APIServerTests", dependencies: [
                .target(name: "APIServer"),
                .product(name: "XCTVapor", package: "vapor"),
            ]
        )
    ]
)
