// dev_panel/override_section.dart
import 'package:flutter/material.dart';
import 'package:peekaboo/override/platform_helper.dart';
import 'dev_panel_controller.dart';

class OverrideSection extends StatefulWidget {
  final DevPanelController controller;
  const OverrideSection({super.key, required this.controller});

  @override
  State<OverrideSection> createState() => _OverrideSectionState();
}

class _OverrideSectionState extends State<OverrideSection> {
  TargetPlatform? selected;

  @override
  void initState() {
    selected = PlatformHelper.override;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("🧪 Platform Override", style: TextStyle(fontWeight: FontWeight.bold)),
        DropdownButton<TargetPlatform>(
          value: selected,
          hint: const Text("Select Platform"),
          items: TargetPlatform.values.map((platform) {
            return DropdownMenuItem(
              value: platform,
              child: Text(platform.name),
            );
          }).toList(),
          onChanged: (val) {
            if (val != null) {
              setState(() => selected = val);
              PlatformHelper.manualOverride(val);
            }
          },
        ),
      ],
    );
  }
}