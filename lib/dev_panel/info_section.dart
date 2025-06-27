// dev_panel/info_section.dart
import 'package:flutter/material.dart';
import 'dev_panel_controller.dart';

class InfoSection extends StatelessWidget {
  final DevPanelController controller;
  const InfoSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("📦 App Info", style: TextStyle(fontWeight: FontWeight.bold)),
        _infoTile("App Name", controller.info.appName),
        _infoTile("Package Name", controller.info.packageName),
        _infoTile("Version", controller.info.version),
        _infoTile("Build Number", controller.info.buildNumber),
        _infoTile("Build Signature", controller.info.buildSignature),
      ],
    );
  }

  Widget _infoTile(String title, String value) {
    return ListTile(
      title: Text(title),
      trailing: Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}