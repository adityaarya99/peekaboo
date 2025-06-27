import 'package:flutter/material.dart';
import '../logger/loggy.dart';
import '../overlay_loading/overlay_loader.dart';
import 'dev_panel_controller.dart';

class DevToolsSection extends StatelessWidget {
  final DevPanelController controller;
  const DevToolsSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("🛠 Dev Tools", style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 12,
          children: [
            ElevatedButton(
              onPressed: () => AppOverlayLoader.show(context),
              child: const Text("Show Loader"),
            ),
            ElevatedButton(
              onPressed: () => AppOverlayLoader.hide(),
              child: const Text("Hide Loader"),
            ),
            ElevatedButton(
              onPressed: () => PeekabooLogger().d("Sample debug log"),
              child: const Text("Log Debug"),
            ),
            ElevatedButton(
              onPressed: () => throw Exception("Simulated crash"),
              child: const Text("Crash App"),
            ),
          ],
        ),
      ],
    );
  }
}
