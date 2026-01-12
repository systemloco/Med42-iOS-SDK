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
            url: "https://systemloco.jfrog.io/artifactory/med42-ios-sdk/Med42SDK/1.1.14/Med42SDK.xcframework.zip",
            checksum: "e2e8fffa329c2a39f4c47dd18c42d9ea469d7da335495429d061f923a54a3b1f"
        )
    ]
)
