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
            url: "https://systemloco.jfrog.io/artifactory/mediscan-ios/MediscanSDK/1.0.20/MediscanSDK.xcframework.zip",
            checksum: "e4f69fbd042c7845957934b6912c0bcf35dea285b252e18d00a64e00a7d69a6a"
        )
    ]
)
