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
            url: "https://systemloco.jfrog.io/artifactory/mediscan-ios/MediscanSDK/1.0.5/MediscanSDK.xcframework.zip",
            checksum: "3fe57b0ef40114ff70dae50e966892aa8d6584000dd3511780bdbf3e3550873b"
        )
    ]
)
