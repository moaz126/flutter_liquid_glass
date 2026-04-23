<div align="center">
  <h1>🔮 NativeTabBar</h1>
  <p>Native iOS bottom navigation bar in Flutter with iOS 26 liquid glass effect via UIBlurEffect.</p>

  [![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=flat&logo=Flutter&logoColor=white)](https://flutter.dev)
  [![iOS](https://img.shields.io/badge/iOS-13.0+-black.svg?style=flat&logo=apple&logoColor=white)]()
  [![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat&logo=swift&logoColor=white)]()
  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
</div>

## Preview
<!-- Add screenshot/GIF here -->

## Why Native?

| Feature | `BackdropFilter` (Flutter) | `UIBlurEffect` (Native) |
| --- | --- | --- |
| **Performance** | Expensive repaints | Hardware accelerated |
| **Authenticity** | Approximation | Pixel-perfect iOS feel |
| **Material** | Standard | iOS 26 Liquid Glass |

## Tradeoffs ⚠️

**Use this when:**
- iOS-only or iOS-first app
- Need real native feel and liquid glass effect

**Don't use when:**
- 100% shared cross-platform codebase
- No Swift knowledge on the team
- Building a fast MVP

| Limitation | Impact |
| --- | --- |
| **Android** | Requires a separate fallback Flutter widget. |
| **State Sync** | Must manually sync state via MethodChannel. |
| **Z-Index** | Native views always render *above* Flutter views. |

## Setup

1. Copy Swift files to `ios/Runner`.
2. Register factory in `AppDelegate.swift`:

```swift
import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let registrar = self.registrar(forPlugin: "NativeTabBarPlugin")!
    let factory = NativeTabBarFactory(messenger: registrar.messenger())
    registrar.register(factory, withId: "native_tab_bar")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

## Usage

```dart
Scaffold(
  body: _pages[_currentIndex],
  extendBody: true, // Crucial for glass effect
  bottomNavigationBar: Platform.isIOS
    ? UiKitView(
        viewType: 'native_tab_bar',
        creationParams: {'currentIndex': _currentIndex},
        creationParamsCodec: const StandardMessageCodec(),
      )
    : BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [ /* Fallback items */ ],
      ),
)
```

## Common Issues

| Issue | Cause & Solution |
| --- | --- |
| **`creationParams` is nil** | Add `FlutterStandardMessageCodec` codec to `UiKitView`. |
| **Black box rendered** | Register view factory *before* calling `super.application()`. |
| **UIKit background crash** | Wrap UI updates in `DispatchQueue.main.async`. |


https://github.com/user-attachments/assets/634fbe41-f5bb-4815-aea1-acc1550d4e6a


## License
MIT
