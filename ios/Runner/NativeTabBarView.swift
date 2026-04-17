import Flutter
import UIKit

// MARK: - NativeTabBarView

final class NativeTabBarView: NSObject, FlutterPlatformView, UITabBarDelegate {

    // MARK: - Properties

    private let tabBar: UITabBar
    private let channel: FlutterMethodChannel
    private var activeColor: UIColor = UIColor(red: 0.0, green: 0.478, blue: 1.0, alpha: 1.0)
    private var inactiveColor: UIColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1.0)

    // MARK: - Init

    init(frame: CGRect, viewId: Int64, messenger: FlutterBinaryMessenger, args: Any?) {
        tabBar = UITabBar(frame: frame)
        tabBar.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        channel = FlutterMethodChannel(
            name: "native_tab_bar/\(viewId)",
            binaryMessenger: messenger
        )
        super.init()
        parseCreationParams(args)
        setupTabBar()
        setupMethodChannel()
    }

    deinit {
        channel.setMethodCallHandler(nil)
        tabBar.removeFromSuperview()
    }

    // MARK: - FlutterPlatformView

    func view() -> UIView { tabBar }

    // MARK: - Parsing

    private func parseCreationParams(_ args: Any?) {
        guard let params = args as? [String: Any] else { return }

        if let tabs = params["tabs"] as? [[String: Any]] {
            tabBar.items = tabs.enumerated().map { index, tab in
                let label = tab["label"] as? String ?? ""
                let iconName = tab["icon"] as? String ?? ""
                let item = UITabBarItem(title: label, image: UIImage(systemName: iconName), tag: index)
                return item
            }
        }

        if let hex = params["activeColor"] as? String {
            activeColor = UIColor(hex: hex) ?? activeColor
        }
        if let hex = params["inactiveColor"] as? String {
            inactiveColor = UIColor(hex: hex) ?? inactiveColor
        }

        tabBar.selectedItem = tabBar.items?.first
    }

    // MARK: - Setup

    private func setupTabBar() {
        tabBar.delegate = self
        tabBar.isTranslucent = true
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        applyBlurAppearance()
    }

    private func applyBlurAppearance() {
        // TODO: Replace this block with the official liquid glass API once
        // the iOS 26 stable SDK releases and the API is finalized.
        if #available(iOS 26.0, *) {
            applySystemUltraThinBlur()
        } else {
            applySystemUltraThinBlur()
        }
    }

    private func applySystemUltraThinBlur() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        appearance.shadowImage = UIImage()
        configureItems(appearance.stackedLayoutAppearance)
        configureItems(appearance.inlineLayoutAppearance)
        configureItems(appearance.compactInlineLayoutAppearance)
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }

    private func configureItems(_ item: UITabBarItemAppearance) {
        item.selected.iconColor = activeColor
        item.selected.titleTextAttributes = [.foregroundColor: activeColor]
        item.normal.iconColor = inactiveColor
        item.normal.titleTextAttributes = [.foregroundColor: inactiveColor]
    }

    // MARK: - Method Channel

    private func setupMethodChannel() {
        channel.setMethodCallHandler { [weak self] call, result in
            DispatchQueue.main.async {
                self?.handle(call, result: result)
            }
        }
    }

    private func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "setSelectedIndex":
            guard let index = call.arguments as? Int else {
                result(FlutterError(code: "INVALID_ARGS", message: "Expected Int", details: nil))
                return
            }
            setSelected(index: index)
            result(nil)

        case "updateBadge":
            guard let args = call.arguments as? [String: Any],
                  let index = args["index"] as? Int,
                  let count = args["count"] as? Int else {
                result(FlutterError(code: "INVALID_ARGS", message: "Expected index and count", details: nil))
                return
            }
            setBadge(count: count, at: index)
            result(nil)

        case "setTabEnabled":
            guard let args = call.arguments as? [String: Any],
                  let index = args["index"] as? Int,
                  let enabled = args["enabled"] as? Bool else {
                result(FlutterError(code: "INVALID_ARGS", message: "Expected index and enabled", details: nil))
                return
            }
            setEnabled(enabled, at: index)
            result(nil)

        default:
            result(FlutterMethodNotImplemented)
        }
    }

    // MARK: - Tab Control

    private func setSelected(index: Int) {
        guard let items = tabBar.items, index < items.count else { return }
        tabBar.selectedItem = items[index]
    }

    private func setBadge(count: Int, at index: Int) {
        guard let items = tabBar.items, index < items.count else { return }
        items[index].badgeValue = count > 0 ? "\(count)" : nil
    }

    private func setEnabled(_ enabled: Bool, at index: Int) {
        guard let items = tabBar.items, index < items.count else { return }
        items[index].isEnabled = enabled
    }

    // MARK: - UITabBarDelegate

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        channel.invokeMethod("onTabSelected", arguments: item.tag)
    }
}
