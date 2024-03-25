// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Core",
  platforms: [.iOS(.v17)],
  products: [
    .library(
      name: "NetworkAPIKit",
      targets: ["NetworkAPIKit"]
    ),
    .library(
      name: "NetworkMonitor",
      targets: ["NetworkMonitor"]
    ),
  ],
  dependencies: [
    .package(path: "../Shared"),
  ],
  targets: [
    .target(
      name: "NetworkAPIKit",
      dependencies: [
        .product(name: "Log", package: "Shared"),
      ]
    ),
    .target(
      name: "NetworkMonitor",
      dependencies: [
        .product(name: "Log", package: "Shared"),
      ]
    ),
    .testTarget(
      name: "CoreTests",
      dependencies: ["NetworkAPIKit"]
    ),
  ]
)
