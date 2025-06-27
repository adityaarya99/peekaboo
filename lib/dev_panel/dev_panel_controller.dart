// dev_panel/dev_panel_controller.dart
import '../bootup/boot_log.dart';
import '../bootup/bootup_service.dart';

class DevPanelController {
  final logs = BootLog().events;
  final info = BootupService().packageInfo;

  bool mockApiEnabled = false;

  void toggleMockApi(bool value) {
    mockApiEnabled = value;
    // Persist if needed
  }

  void clearLogs() {
    BootLog().clear();
  }
}
