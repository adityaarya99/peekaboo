// dev_panel/toggles_section.dart
import 'package:flutter/material.dart';
import 'dev_panel_controller.dart';

class TogglesSection extends StatefulWidget {
  final DevPanelController controller;
  const TogglesSection({super.key, required this.controller});

  @override
  State<TogglesSection> createState() => _TogglesSectionState();
}

class _TogglesSectionState extends State<TogglesSection> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: const Text("Enable Mock API"),
      value: widget.controller.mockApiEnabled,
      onChanged: (val) {
        setState(() => widget.controller.toggleMockApi(val));
      },
    );
  }
}