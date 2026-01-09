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
            url: "https://systemloco.jfrog.io/artifactory/med42-ios/Med42SDK/1.1.4/Med42SDK.xcframework.zip",
            checksum: "6cb28eb3e9f1fcc8e1ddbbfbe0144613c6001e6b1f3ce101d6e7a698766c3573"
        )
    ]
)
