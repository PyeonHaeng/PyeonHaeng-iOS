// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "APIService",
  platforms: [.iOS(.v17)],
  products: [
    .library(
      name: "CreditsAPI",
      targets: ["CreditsAPI"]
    ),
    .library(
      name: "CreditsAPISupport",
      targets: ["CreditsAPISupport"]
    ),
    .library(
      name: "HomeAPI",
      targets: ["HomeAPI"]
    ),
    .library(
      name: "HomeAPISupport",
      targets: ["HomeAPISupport"]
    ),
    .library(
      name: "NoticeAPI",
      targets: ["NoticeAPI"]
    ),
    .library(
      name: "NoticeAPISupport",
      targets: ["NoticeAPISupport"]
    ),
    .library(
      name: "ProductInfoAPI",
      targets: ["ProductInfoAPI"]
    ),
    .library(
      name: "ProductInfoAPISupport",
      targets: ["ProductInfoAPISupport"]
    ),
    .library(
      name: "SearchAPI",
      targets: ["SearchAPI"]
    ),
    .library(
      name: "SearchAPISupport",
      targets: ["SearchAPISupport"]
    ),
  ],
  dependencies: [
    .package(path: "../Core"),
    .package(path: "../Entity"),
  ],
  targets: [
    .target(
      name: "CreditsAPI",
      dependencies: [
        .product(name: "Network", package: "Core"),
        .product(name: "Entity", package: "Entity"),
      ]
    ),
    .target(
      name: "CreditsAPISupport",
      dependencies: [
        "CreditsAPI",
      ],
      resources: [.process("Mocks")]
    ),
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
      name: "NoticeAPI",
      dependencies: [
        .product(name: "Network", package: "Core"),
        .product(name: "Entity", package: "Entity"),
      ]
    ),
    .target(
      name: "NoticeAPISupport",
      dependencies: [
        "NoticeAPI",
      ],
      resources: [.process("Mocks")]
    ),
    .target(
      name: "ProductInfoAPI",
      dependencies: [
        .product(name: "Network", package: "Core"),
        .product(name: "Entity", package: "Entity"),
      ]
    ),
    .target(
      name: "ProductInfoAPISupport",
      dependencies: [
        "ProductInfoAPI",
      ],
      resources: [.process("Mocks")]
    ),
    .target(
      name: "SearchAPI",
      dependencies: [
        .product(name: "Network", package: "Core"),
        .product(name: "Entity", package: "Entity"),
      ]
    ),
    .target(
      name: "SearchAPISupport",
      dependencies: [
        "SearchAPI",
      ],
      resources: [.process("Mocks")]
    ),
  ]
)
