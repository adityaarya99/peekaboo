import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'boot_log.dart';

class BootupService {
  static final BootupService _instance = BootupService._internal();

  factory BootupService() => _instance;

  BootupService._internal();

  late final FlutterSecureStorage secureStorage;
  late final PackageInfo packageInfo;
  late final SharedPreferences prefs;

  Future<void> initialize() async {
    BootLog().log("🔧 BootupService: Starting initialization");

    secureStorage = const FlutterSecureStorage();
    BootLog().log("🛡 Secure storage initialized");

    prefs = await SharedPreferences.getInstance();
    BootLog().log("📦 SharedPreferences initialized");

    packageInfo = await PackageInfo.fromPlatform();
    BootLog().log("📱 App version: ${packageInfo.version} (${packageInfo.buildNumber})");

    await _checkFirstLaunchOrUpgrade();
  }

  Future<void> _checkFirstLaunchOrUpgrade() async {
    final lastVersion = prefs.getString('app_last_version');
    final currentVersion = packageInfo.version;

    if (lastVersion == null) {
      BootLog().log("🆕 First time launch detected");
    } else if (lastVersion != currentVersion) {
      BootLog().log("🔄 App updated: $lastVersion → $currentVersion");
    } else {
      BootLog().log("✅ No version change");
    }

    await prefs.setString('app_last_version', currentVersion);
  }
}

// ℹ️ How to use in your app:
//
// import 'package:peekaboo/peekaboo.dart';
//
// In your main.dart or custom entry point:
// await BootupService().initialize();
