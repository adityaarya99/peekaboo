/// Central registry for any overrides you want to use across your app.
class OverrideRegistry {
  static final OverrideRegistry _instance = OverrideRegistry._internal();

  factory OverrideRegistry() => _instance;
  OverrideRegistry._internal();

  /// Manual platform override (null = use real platform)
  String? platformOverride;

  /// Global feature flags
  final Map<String, bool> featureFlags = {};

  /// Arbitrary override values
  final Map<String, dynamic> config = {};

  /// Set or update a feature flag
  void setFlag(String key, bool value) {
    featureFlags[key] = value;
  }

  bool isEnabled(String key) => featureFlags[key] ?? false;

  void setConfig(String key, dynamic value) {
    config[key] = value;
  }

  dynamic getConfig(String key) => config[key];

  void clear() {
    platformOverride = null;
    featureFlags.clear();
    config.clear();
  }
}
