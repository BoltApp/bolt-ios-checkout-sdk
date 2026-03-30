// swift-tools-version:5.9
// This file lives in the PUBLIC distribution repo: github.com/BoltApp/bolt-ios-checkout-sdk
// Update the url and checksum each time a new release is cut.
// The XCFramework is self-contained — all dependencies are statically linked in.

import PackageDescription

let package = Package(
    name: "BoltCheckoutSDK",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "BoltCheckoutSDK",
            targets: ["BoltCheckoutSDK"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "BoltCheckoutSDK",
            // RELEASE_URL — replace with the GitHub release asset URL for each version
            url: "https://github.com/BoltApp/bolt-ios-checkout-sdk/releases/download/v0.4.2/BoltCheckoutSDK.xcframework.zip",
            // RELEASE_CHECKSUM — replace with output of: swift package compute-checksum BoltCheckoutSDK.xcframework.zip
            checksum: "793aa0b9955c68e54cd715f2b034ab81091f5063b50b938dfe67bcd3bf10552f"
        )
    ]
)
