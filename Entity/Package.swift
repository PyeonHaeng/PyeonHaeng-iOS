// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "Entity",
  platforms: [.iOS(.v17)],
  products: [
    .library(
      name: "Entity",
      targets: ["Entity"]
    ),
  ],
  targets: [
    .target(
      name: "Entity"
    ),
  ]
)
