// dev_panel/bootlog_section.dart
import 'package:flutter/material.dart';
import 'dev_panel_controller.dart';

class BootlogSection extends StatefulWidget {
  final DevPanelController controller;
  const BootlogSection({super.key, required this.controller});

  @override
  State<BootlogSection> createState() => _BootlogSectionState();
}

class _BootlogSectionState extends State<BootlogSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("📜 Boot Logs", style: TextStyle(fontWeight: FontWeight.bold)),
        ElevatedButton(
          onPressed: () {
            widget.controller.clearLogs();
            setState(() {});
          },
          child: const Text("Clear Boot Logs"),
        ),
        ...widget.controller.logs.map((e) => ListTile(
          dense: true,
          title: Text(e.message),
          subtitle: Text(e.timestamp.toIso8601String()),
        )),
      ],
    );
  }
}