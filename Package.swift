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
            url: "https://systemloco.jfrog.io/artifactory/med42-ios-sdk/Med42SDK/1.2.2/Med42SDK.xcframework.zip",
            checksum: "68f8bc69b5ced473d0c66ba9446a9284184dc1a9ca753a49b17a98c7640e77ff"
        )
    ]
)
