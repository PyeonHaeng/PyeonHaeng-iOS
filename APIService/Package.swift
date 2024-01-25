// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "APIService",
  platforms: [.iOS(.v17)],
  products: [
    .library(
      name: "HomeAPI",
      targets: ["HomeAPI"]
    ),
    .library(
      name: "HomeAPISupport",
      targets: ["HomeAPISupport"]
    ),
  ],
  dependencies: [
    .package(path: "../Core"),
  ],
  targets: [
    .target(
      name: "HomeAPI",
      dependencies: [
        .product(name: "Network", package: "Core"),
      ]
    ),
    .target(
      name: "HomeAPISupport",
      dependencies: [
        "HomeAPI",
      ],
      resources: [.process("HomeProductResponse.json")]
    ),
  ]
)
