// swift-tools-version:5.9
// This file lives in the PUBLIC distribution repo: github.com/BoltApp/bolt-ios-checkout-sdk
// Update the url and checksum each time a new release is cut.
// The XCFramework is self-contained — all dependencies are statically linked in.

import PackageDescription

let package = Package(
    name: "Bolt",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Bolt",
            targets: ["Bolt"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "Bolt",
            // RELEASE_URL — replace with the GitHub release asset URL for each version
            url: "https://github.com/BoltApp/bolt-ios-checkout-sdk/releases/download/v0.2.5/Bolt.xcframework.zip",
            // RELEASE_CHECKSUM — replace with output of: swift package compute-checksum Bolt.xcframework.zip
            checksum: "4cae310ca50f55d583f2a3599999c2a80496c63c87bf3c2f051d6844835c57a0"
        )
    ]
)
