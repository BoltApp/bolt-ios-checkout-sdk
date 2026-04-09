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
            url: "https://github.com/BoltApp/bolt-ios-checkout-sdk/releases/download/v0.7.0/BoltCheckoutSDK.xcframework.zip",
            // RELEASE_CHECKSUM — replace with output of: swift package compute-checksum BoltCheckoutSDK.xcframework.zip
            checksum: "60cf5eae1946cc98aac6275f05e74accdd431c5578c56c3dba7a0ba9a229a38f"
        )
    ]
)
