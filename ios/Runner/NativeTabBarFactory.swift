import Flutter
import UIKit

// MARK: - NativeTabBarFactory

final class NativeTabBarFactory: NSObject, FlutterPlatformViewFactory {

    // MARK: - Properties

    private let messenger: FlutterBinaryMessenger

    // MARK: - Init

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    // MARK: - FlutterPlatformViewFactory

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        NativeTabBarView(
            frame: frame,
            viewId: viewId,
            messenger: messenger,
            args: args
        )
    }

    /// Required to receive creationParams as a decoded object from Flutter.
    /// Without this, `args` in `create` will always be nil.
    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        FlutterStandardMessageCodec.sharedInstance()
    }
}
