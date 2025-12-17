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
            url: "https://systemloco.jfrog.io/artifactory/mediscan-ios/MediscanSDK/1.0.14/MediscanSDK.xcframework.zip",
            checksum: "78a5a6a5f0def3a732e061e2d551d4c3817e473a9f5a49be44b935c6bce1319e"
        )
    ]
)
