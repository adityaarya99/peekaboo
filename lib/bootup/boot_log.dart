import 'package:flutter/foundation.dart';

class BootLog {
  static final BootLog _instance = BootLog._internal();
  final List<BootEvent> _events = [];

  BootLog._internal();

  factory BootLog() => _instance;

  void log(String message) {
    final event = BootEvent(message: message, timestamp: DateTime.now());
    _events.add(event);
    if (kDebugMode) {
      debugPrint("[BOOT] ${event.timestamp.toIso8601String()} - ${event.message}");
    }
  }

  List<BootEvent> get events => List.unmodifiable(_events);

  void clear() => _events.clear();
}

class BootEvent {
  final String message;
  final DateTime timestamp;

  BootEvent({
    required this.message,
    required this.timestamp,
  });
}


// ℹ️ How to use in your app:
//
// import 'package:peekaboo/peekaboo.dart';
//
// Future<void> initializeApp() async {
//   BootLog().log("Starting App Initialization...");
//   // Your init logic
//   BootLog().log("SecureStorage initialized.");
//   BootLog().log("Version check complete.");
// }
