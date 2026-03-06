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
            url: "https://systemloco.jfrog.io/artifactory/med42-ios-sdk/Med42SDK/1.2.1/Med42SDK.xcframework.zip",
            checksum: "9110378b5ec3427536181c99ecfd772e3c1757694ce78b4ba0c27401cafff1aa"
        )
    ]
)
