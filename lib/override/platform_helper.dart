import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;

class PlatformHelper {
  /// Optional override for test or simulation
  static TargetPlatform? _overridePlatform;

  /// Returns the effective override
  static TargetPlatform get override =>
      _overridePlatform ?? defaultTargetPlatform;

  /// Set a manual override (useful for dev or test)
  static void manualOverride(TargetPlatform override) {
    _overridePlatform = override;
  }

  /// Clear manual override
  static void clearOverride() {
    _overridePlatform = null;
  }

  /// Check if Android
  static bool get isAndroid => override == TargetPlatform.android;

  /// Check if iOS
  static bool get isIOS => override == TargetPlatform.iOS;

  /// Check if macOS
  static bool get isMacOS => override == TargetPlatform.macOS;

  /// Check if Windows
  static bool get isWindows => override == TargetPlatform.windows;
}
