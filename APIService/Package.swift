// swift-tools-version: 5.9

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
    .library(
      name: "ProductInfoAPI",
      targets: ["ProductInfoAPI"]
    ),
    .library(
      name: "ProductInfoAPISupport",
      targets: ["ProductInfoAPISupport"]
    ),
  ],
  dependencies: [
    .package(path: "../Core"),
    .package(path: "../Entity"),
  ],
  targets: [
    .target(
      name: "HomeAPI",
      dependencies: [
        .product(name: "Network", package: "Core"),
        .product(name: "Entity", package: "Entity"),
      ]
    ),
    .target(
      name: "HomeAPISupport",
      dependencies: [
        "HomeAPI",
      ],
      resources: [.process("Mocks")]
    ),
    .target(
      name: "ProductInfoAPI",
      dependencies: [
        "HomeAPI",
      ]
    ),
    .target(
      name: "ProductInfoAPISupport",
      dependencies: [
        "ProductInfoAPI",
      ],
      resources: [.process("Mocks")]
    ),
  ]
)
