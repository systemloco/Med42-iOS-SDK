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
            url: "https://systemloco.jfrog.io/artifactory/med42-ios-sdk/Med42SDK/1.1.5/Med42SDK.xcframework.zip",
            checksum: "eb4b7f62773161a9e3a899d33355b81e2b000b04817f2844c85011ce180d8164"
        )
    ]
)
