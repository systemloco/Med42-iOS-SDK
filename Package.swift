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
            url: "https://systemloco.jfrog.io/artifactory/mediscan-ios/MediscanSDK/1.0.18/MediscanSDK.xcframework.zip",
            checksum: "ee36f546135e93bfa87db2be27ca9af444b437e1931134cca3cdad0e5a7f635b"
        )
    ]
)
