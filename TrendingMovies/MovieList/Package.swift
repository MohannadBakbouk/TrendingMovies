// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MovieList",
    platforms: [
       .iOS(.v18)
    ],
    products: [
        .library(
            name: "MovieList",
            targets: ["MovieList"]
        ),
    ],
    dependencies: [
        .package(name: "Core", path: "../Core"),
        .package(name: "DesignSystem", path: "../DesignSystem"),
        .package(name: "MovieDetail", path: "../MovieDetail")
    ],
    targets: [
        .target(
            name: "MovieList"
            ,dependencies: [
                .product(name: "Core", package: "Core"),
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "MovieDetail", package: "MovieDetail")
             ]
        ),
        .testTarget(
            name: "MovieListTests",
            dependencies: [
                "MovieList"
            ]
        )
    ]
)
