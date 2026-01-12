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
            url: "https://systemloco.jfrog.io/artifactory/med42-ios-sdk/Med42SDK/1.1.12/Med42SDK.xcframework.zip",
            checksum: "cec11c3024b0c77e6f8bbac7ff1c9a66addf2a879348cfa78bbab8c858873d23"
        )
    ]
)
