import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'fallback_tab_bar.dart';
import 'native_tab_bar_controller.dart';

// MARK: - Types

typedef ControllerCreatedCallback = void Function(NativeTabBarController);

// MARK: - NativeTabBar

/// iOS-native bottom tab bar using UiKitView (platform view).
/// On non-iOS platforms renders [FallbackTabBar].
///
/// *Performance contract*:
/// - Created once via a [GlobalKey] in MainShell; never rebuilt on tab changes.
/// - No setState() in the hosting State — all tab-change state lives in
///   NavigationCubit. The only state flip is the one-time "view is ready"
///   transition handled via [ValueNotifier].
final class NativeTabBar extends StatefulWidget {
  const NativeTabBar({
    super.key,
    required this.onControllerCreated,
    required this.onTabSelected,
    this.fallbackSelectedIndex = 0,
  });

  /// Called exactly once when the underlying platform view is ready.
  final ControllerCreatedCallback onControllerCreated;

  /// Called whenever the native bar reports a tap (both iOS and fallback).
  final ValueChanged<int> onTabSelected;

  /// Used only on non-iOS platforms by [FallbackTabBar].
  final int fallbackSelectedIndex;

  @override
  State<NativeTabBar> createState() => _NativeTabBarState();
}

class _NativeTabBarState extends State<NativeTabBar> {
  // ValueNotifier avoids calling setState() in the UiKitView host widget.
  final _isCreated = ValueNotifier<bool>(false);
  NativeTabBarController? _controller;

  static final _creationParams = {
    'tabs': const [
      {'label': 'Home', 'icon': 'house.fill'},
      {'label': 'Search', 'icon': 'magnifyingglass'},
      {'label': 'Stats', 'icon': 'chart.bar.fill'},
      {'label': 'Profile', 'icon': 'person.fill'},
    ],
    'activeColor': '#007AFF',
    'inactiveColor': '#8E8E93',
    'backgroundColor': 'transparent',
  };

  @override
  void dispose() {
    _controller?.dispose();
    _isCreated.dispose();
    super.dispose();
  }

  void _onPlatformViewCreated(int viewId) {
    _controller = NativeTabBarController(viewId);
    // widget.onTabSelected is accessed via the State.widget getter so it
    // always calls the *current* callback even if the parent rebuilds.
    _controller!.tabSelectionStream.listen((tabIndex) {
      widget.onTabSelected(tabIndex);
    });
    widget.onControllerCreated(_controller!);
    _isCreated.value =
        true; // No setState — only ValueListenableBuilder rebuilds
  }

  double _tabBarHeight(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    // Standard UITabBar content area is 49pt; safe area is added on top.
    return 49.0 + bottomPadding;
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb || !Platform.isIOS) {
      return FallbackTabBar(
        selectedIndex: widget.fallbackSelectedIndex,
        onTabSelected: widget.onTabSelected,
      );
    }

    final height = _tabBarHeight(context);

    return SizedBox(
      height: height,
      child: Stack(
        children: [
          // Platform view is always in the tree; RepaintBoundary prevents
          // Flutter from repainting it on unrelated parent rebuilds.
          RepaintBoundary(
            child: UiKitView(
              viewType: 'native_tab_bar',
              creationParams: _creationParams,
              creationParamsCodec: const StandardMessageCodec(),
              onPlatformViewCreated: _onPlatformViewCreated,
            ),
          ),
          // Transparent placeholder covers the view until it is ready,
          // preventing a potential single-frame flash on first render.
          ValueListenableBuilder<bool>(
            valueListenable: _isCreated,
            builder: (context, created, child) {
              if (created) return const SizedBox.shrink();
              return SizedBox(
                height: height,
                child: const ColoredBox(color: Color(0x00000000)),
              );
            },
          ),
        ],
      ),
    );
  }
}
