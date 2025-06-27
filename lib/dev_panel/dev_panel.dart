// dev_panel/dev_panel.dart
import 'package:flutter/material.dart';
import 'bootlog_section.dart';
import 'info_section.dart';
import 'toggles_section.dart';
import 'override_section.dart';
import 'dev_tools_section.dart';
import 'dev_panel_controller.dart';

class DevPanel extends StatelessWidget {
  const DevPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DevPanelController();

    return Scaffold(
      appBar: AppBar(title: const Text("🛠 Dev Panel")),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          InfoSection(controller: controller),
          const SizedBox(height: 16),
          TogglesSection(controller: controller),
          const SizedBox(height: 16),
          DevToolsSection(controller: controller),
          const SizedBox(height: 16),
          BootlogSection(controller: controller),
          const SizedBox(height: 16),
          OverrideSection(controller: controller),
        ],
      ),
    );
  }
}
