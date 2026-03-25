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
4. Add **BoltCheckoutSDK** to your app target

### Package.swift

```swift
dependencies: [
    .package(url: "https://github.com/BoltApp/bolt-ios-checkout-sdk", from: "0.1.0")
],
targets: [
    .target(
        name: "YourApp",
        dependencies: ["BoltCheckoutSDK"]
    )
]
```

---

## Usage

Import the SDK in any file:

```swift
import BoltCheckoutSDK
```

### Configuration

Set your publishable key and environment before using any SDK feature. The publishable key is available in Merchant Dashboard → Developers → API.

```swift
Bolt.ClientProperties.shared.environment = .production
Bolt.ClientProperties.shared.publishableKey = "your-publishable-key"
```

Register Bolt fonts if you use any UI components:

```swift
Bolt.UI.registerFonts()
```

### Login (Authorization)

#### SwiftUI

Use the `.boltAuthorize()` view modifier:

```swift
@State private var isAuthorizing = false

var body: some View {
    Button("Sign in with Bolt") {
        isAuthorizing = true
    }
    .boltAuthorize(
        isAuthorizing: $isAuthorizing,
        email: "user@example.com",
        context: .checkout,
        onAccountCheck: { accountExists in
            // Called when account existence check completes
        },
        completion: { result in
            switch result {
            case .completed(let authorizationCode, let codeVerifier):
                // Exchange auth code for access token via OAuthToken endpoint
            case .canceled:
                break
            case .failed(let error):
                // Handle error
            }
        }
    )
}
```

#### UIKit

```swift
Bolt.Login.startAuthorization(
    email: "user@example.com",
    parentViewController: self,
    context: .checkout,
    onAccountCheck: { accountExists in
        // Called when account existence check completes
    },
    completion: { result in
        switch result {
        case .completed(let authorizationCode, let codeVerifier):
            // Exchange auth code for access token via OAuthToken endpoint
        case .canceled:
            break
        case .failed(let error):
            // Handle error
        }
    }
)
```

### Account Detection

Check whether a user has a Bolt account before showing a login prompt:

```swift
Bolt.Account.detectAccount(email: "user@example.com") { result in
    switch result {
    case .success(let hasAccount):
        if hasAccount {
            // Show Bolt login option
        }
    case .failure(let error):
        // Handle error
    }
}
```

### Credit Card Tokenization

Securely tokenize credit card details:

```swift
let tokenizer = Bolt.CreditCardTokenizer()

tokenizer.generateToken(cardNumber: "4111111111111111", cvv: "123") { result in
    switch result {
    case .success(let token):
        // Use token.token, token.last4, token.bin, token.network, token.tokenExpiry
    case .failure(let error):
        // Handle error
    }
}
```

### UI Components

The SDK provides pre-built UI components available in both SwiftUI and UIKit.

#### SwiftUI

```swift
// Sign-in button
Bolt.UI.SignInButton(context: .checkout) {
    // Handle button tap — start authorization flow
}

// Account creation checkbox
Bolt.UI.AccountCheckbox(
    merchantName: "My Store",
    isChecked: true,
    onCheckboxTap: { isChecked in },
    onLinkTap: { url in }
)

// Email info button
Bolt.UI.EmailInfoButton { url in
    // Handle link tap
}

// Signed-in status button
Bolt.UI.SignedInStatusButton { url in
    // Handle link tap
}
```

#### UIKit

```swift
// Sign-in button
let signInVC = Bolt.UI.SignInButtonViewController(context: .checkout)
signInVC.delegate = self

// Account checkbox
let checkboxVC = Bolt.UI.AccountCheckboxViewController(merchantName: "My Store", isChecked: true)
checkboxVC.delegate = self

// Email info button
let emailInfoVC = Bolt.UI.EmailInfoButtonViewController()
emailInfoVC.delegate = self

// Signed-in status button
let statusVC = Bolt.UI.SignedInStatusButtonViewController()
statusVC.delegate = self
```

### Analytics

Log checkout events for analytics:

```swift
// Set common properties (e.g. session info)
Bolt.Analytics.setCommonProperties(["sessionId": "abc123"])

// Log an event
Bolt.Analytics.log(.checkoutButtonTapped)
Bolt.Analytics.log(.paymentMethodSelected(.creditCard), ["additional": "value"])
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
