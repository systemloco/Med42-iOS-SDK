// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Med42SDK",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "Med42SDK",
            targets: ["Med42SDK"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "Med42SDK",
            url: "https://systemloco.jfrog.io/artifactory/med42-ios-sdk/Med42SDK/1.1.10/Med42SDK.xcframework.zip",
            checksum: "5a62d20ec607c008d3f6223a125ec7d0fc6c8bba9906c90d9925c20936fb73e9"
        )
    ]
)
