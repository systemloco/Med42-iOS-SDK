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
            url: "https://systemloco.jfrog.io/artifactory/med42-ios-sdk/Med42SDK/1.4.0/Med42SDK.xcframework.zip",
            checksum: "2351fb10475e0ebced8ecf48ac6403bbb2cdb0e7c2a2c8004f4f37c3d4113b54"
        )
    ]
)
