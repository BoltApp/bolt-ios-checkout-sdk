# Bolt iOS SDK

Swift Package Manager distribution for the Bolt iOS SDK — a native checkout, payment, and account authentication SDK for iOS.

**Minimum deployment target:** iOS 16
**Swift:** 5.9+

---

## Installation

### Xcode (recommended)

1. In Xcode, go to **File → Add Package Dependencies**
2. Enter the repository URL:
   ```
   https://github.com/BoltApp/bolt-ios-checkout-sdk
   ```
3. Select the version rule (e.g. **Up to Next Major** from `0.1.0`)
4. Add **Bolt** to your app target

### Package.swift

```swift
dependencies: [
    .package(url: "https://github.com/BoltApp/bolt-ios-checkout-sdk", from: "0.1.0")
],
targets: [
    .target(
        name: "YourApp",
        dependencies: ["Bolt"]
    )
]
```

---

## Usage

Import the SDK in any file:

```swift
import Bolt
```

### Managed Checkout

Presents a full-screen Bolt checkout UI — handles shipping, payment, and order confirmation.

```swift
// 1. Create a Bolt order token on your backend using the CreateOrderToken API
// 2. Initialize BoltCheckout (keys from Merchant Dashboard → Developers → API)
let checkout = BoltCheckout(
    publishableKey: "your-publishable-key",
    apiKey: "your-api-key",
    merchantDivisionId: "your-division-id",
    environment: .production
)

// 3. Start checkout
checkout.startCheckout(
    presentingViewController: self,
    orderToken: orderToken,
    delegate: self
)

// 4. Handle callbacks
extension MyViewController: BoltCheckoutDelegate {
    func checkoutDidComplete(orderReference: String) { }
    func checkoutDidFail(at step: BoltCheckoutStep, error: Error) { }
    func checkoutDidCancel(at step: BoltCheckoutStep) { }
    func checkoutDidReceiveAuthCode(_ authCode: String) { }
}
```

### Embedded Checkout

Use your own checkout UI with Bolt's secure card tokenization.

```swift
let configuration = Bolt(environment: .production)
    .withPublishableKey("your-publishable-key")
    .withOrderToken(orderToken)
    .configuration()

Bolt.CreditCardViewFactory.presentCreditCardView(
    configuration: configuration,
    presentingViewController: self,
    delegate: self
)

extension MyViewController: BoltCreditCardResultDelegate {
    func creditCardViewDidFinish(creditCardInput: Bolt.Api.CreditCardInput?, error: String?) { }
}
```

### Apple Pay

```swift
checkout.getApplePayContext(
    orderToken: orderToken,
    merchantName: "My Store",
    merchantAppleId: "merchant.com.myapp",
    merchantCountryCode: "US",
    applePayDelegate: self
) { [weak self] result in
    if case .success(let applePay) = result {
        self?.applePay = applePay
        // Show PKPaymentButton and call applePay.start() on tap
    }
}
```

### Single Sign-On

```swift
checkout.startLogin(presentingViewController: self) { result in
    switch result {
    case .completed(let authorizationCode):
        // Exchange auth code for Bolt access token
    case .canceled: break
    case .failed(let error): break
    }
}
```

### Account Detection

Check whether a user has a Bolt account before showing a login prompt:

```swift
Bolt.Account.detectAccount(
    publishableKey: "your-publishable-key",
    email: "user@example.com"
) { result in
    if case .success(let hasAccount) = result, hasAccount {
        // Show Bolt login option
    }
}
```

---

## Camera Permission

The SDK uses the camera for credit card scanning. Add this key to your app's `Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>Your camera is used to automatically scan credit card info.</string>
```

---

## Documentation

Full integration guide, configuration options, and API reference:
[BoltApp/bolt-ios-managed-checkout-sdk](https://github.com/BoltApp/bolt-ios-managed-checkout-sdk)

## Support

[support@bolt.com](mailto:support@bolt.com)
