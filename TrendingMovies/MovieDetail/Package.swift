// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MovieDetail",
    platforms: [
       .iOS(.v18)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MovieDetail",
            targets: ["MovieDetail"]
        ),
    ],
    dependencies: [
        .package(name: "Core", path: "../Core"),
        .package(name: "DesignSystem", path: "../DesignSystem"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MovieDetail"
            ,dependencies: [
                .product(name: "Core", package: "Core"),
                .product(name: "DesignSystem", package: "DesignSystem")
             ]
        ),
        

    ]
)
