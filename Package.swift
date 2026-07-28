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
            url: "https://systemloco.jfrog.io/artifactory/med42-ios-sdk/Med42SDK/1.3.0/Med42SDK.xcframework.zip",
            checksum: "85946823bf550f4f3eec155f43462bebf793c95da938b9268857d4b87817805a"
        )
    ]
)
