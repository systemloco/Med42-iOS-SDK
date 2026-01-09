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
            url: "https://systemloco.jfrog.io/artifactory/med42-ios-sdk/Med42SDK/1.1.2/Med42SDK.xcframework.zip",
            checksum: "2b6eef4f35a74f87fc1e68b8946390a550939d44a31db32c11b2780fbfc60ce5"
        )
    ]
)
