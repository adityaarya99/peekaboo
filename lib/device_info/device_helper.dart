import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/foundation.dart';

class DeviceHelper {
  static final DeviceHelper _instance = DeviceHelper._internal();

  factory DeviceHelper() => _instance;
  DeviceHelper._internal();

  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<Map<String, dynamic>> getDeviceData() async {
    if (kIsWeb) {
      return {
        'platform': 'web',
        'info': await _deviceInfo.webBrowserInfo,
      };
    }

    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      return {
        'platform': 'android',
        'brand': androidInfo.brand,
        'model': androidInfo.model,
        'version': androidInfo.version.release,
        'sdkInt': androidInfo.version.sdkInt,
        'isPhysicalDevice': androidInfo.isPhysicalDevice,
        'device': androidInfo.device,
      };
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      return {
        'platform': 'ios',
        'name': iosInfo.name,
        'systemName': iosInfo.systemName,
        'systemVersion': iosInfo.systemVersion,
        'model': iosInfo.model,
        'isPhysicalDevice': iosInfo.isPhysicalDevice,
        'identifierForVendor': iosInfo.identifierForVendor,
      };
    } else {
      return {'platform': 'unknown'};
    }
  }

  Future<Map<String, String>> getAppInfo() async {
    final info = await PackageInfo.fromPlatform();
    return {
      'appName': info.appName,
      'packageName': info.packageName,
      'version': info.version,
      'buildNumber': info.buildNumber,
    };
  }

  Future<bool> isEmulator() async {
    if (kIsWeb) return false;

    if (Platform.isAndroid) {
      final info = await _deviceInfo.androidInfo;
      return !info.isPhysicalDevice;
    } else if (Platform.isIOS) {
      final info = await _deviceInfo.iosInfo;
      return !info.isPhysicalDevice;
    }
    return false;
  }
}

// ℹ️ How to use in your app:
//
// import 'package:peekaboo/peekaboo.dart';
//
// final info = await DeviceHelper().getDeviceData();
// final app = await DeviceHelper().getAppInfo();
// final isEmulator = await DeviceHelper().isEmulator();
