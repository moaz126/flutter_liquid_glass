import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)

    // MARK: Register NativeTabBar platform view factory
    guard let registrar = engineBridge.pluginRegistry.registrar(forPlugin: "NativeTabBar") else {
      return
    }
    registrar.register(
      NativeTabBarFactory(messenger: registrar.messenger()),
      withId: "native_tab_bar"
    )
  }
}
