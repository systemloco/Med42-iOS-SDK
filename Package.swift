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
            url: "https://systemloco.jfrog.io/artifactory/mediscan-ios/MediscanSDK/1.0.15/MediscanSDK.xcframework.zip",
            checksum: "004101ea105654500801e7eff99402e7f8754fdb71b5e4e4e7b47935018a1135"
        )
    ]
)
