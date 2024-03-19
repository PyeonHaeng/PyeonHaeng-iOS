// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Core",
  platforms: [.iOS(.v17)],
  products: [
    .library(
      name: "Network",
      targets: ["Network"]
    ),
  ],
  dependencies: [
    .package(path: "../Shared"),
  ],
  targets: [
    .target(
      name: "Network",
      dependencies: [
        .product(name: "Log", package: "Shared"),
      ]
    ),
    .testTarget(
      name: "CoreTests",
      dependencies: ["Network"]
    ),
  ]
)
