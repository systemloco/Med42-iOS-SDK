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
            checksum: "085ef94a0ffe13dee5076bd8d365898dd2b13f46b1d9a0c972382da47ba16613"
        )
    ]
)
