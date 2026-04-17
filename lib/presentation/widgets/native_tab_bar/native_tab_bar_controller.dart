import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

// MARK: - NativeTabBarController

final class NativeTabBarController {
  NativeTabBarController(int viewId)
    : _channel = MethodChannel('native_tab_bar/$viewId') {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  final MethodChannel _channel;
  final _tabSelectionController = StreamController<int>.broadcast();
  bool _isDisposed = false;
  DateTime? _lastSetIndexTime;

  Stream<int> get tabSelectionStream => _tabSelectionController.stream;

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    if (_isDisposed) return;
    if (call.method == 'onTabSelected') {
      _tabSelectionController.add(call.arguments as int);
    }
  }

  Future<void> setSelectedIndex(int index) async {
    if (_isDisposed) return;
    final now = DateTime.now();
    if (_lastSetIndexTime != null &&
        now.difference(_lastSetIndexTime!) <
            const Duration(milliseconds: 100)) {
      return;
    }
    _lastSetIndexTime = now;
    try {
      await _channel.invokeMethod<void>('setSelectedIndex', index);
    } on MissingPluginException catch (e) {
      debugPrint('NativeTabBarController: setSelectedIndex failed: $e');
    }
  }

  Future<void> updateBadge(int index, int count) async {
    if (_isDisposed) return;
    try {
      await _channel.invokeMethod<void>('updateBadge', {
        'index': index,
        'count': count,
      });
    } on MissingPluginException catch (e) {
      debugPrint('NativeTabBarController: updateBadge failed: $e');
    }
  }

  Future<void> setTabEnabled(int index, {required bool enabled}) async {
    if (_isDisposed) return;
    try {
      await _channel.invokeMethod<void>('setTabEnabled', {
        'index': index,
        'enabled': enabled,
      });
    } on MissingPluginException catch (e) {
      debugPrint('NativeTabBarController: setTabEnabled failed: $e');
    }
  }

  void dispose() {
    _isDisposed = true;
    _channel.setMethodCallHandler(null);
    _tabSelectionController.close();
  }
}
