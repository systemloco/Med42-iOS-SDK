// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MediscanSDK",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "MediscanSDK",
            targets: ["MediscanSDK"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "MediscanSDK",
            url: "https://systemloco.jfrog.io/artifactory/mediscan-ios/MediscanSDK/1.0.16/MediscanSDK.xcframework.zip",
            checksum: "e3f16e765b3e5eeb74ed067d0512eb3faa0c7ad07a01ccf4cb8ac9c100254806"
        )
    ]
)
