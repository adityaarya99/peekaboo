import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class PeekabooLogger {
  static final PeekabooLogger _instance = PeekabooLogger._internal();

  late final Logger _logger;

  factory PeekabooLogger() {
    return _instance;
  }

  PeekabooLogger._internal() {
    _logger = Logger(
      printer: kReleaseMode
          ? SimplePrinter(colors: false)
          : PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 100,
        colors: true,
        printEmojis: true,
        printTime: true,
      ),
      level: kReleaseMode ? Level.warning : Level.debug,
    );
  }

  void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (!kReleaseMode) _logger.d(message, error: error, stackTrace: stackTrace);
  }

  void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (!kReleaseMode) _logger.i(message, error: error, stackTrace: stackTrace);
  }

  void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  void v(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (!kReleaseMode) _logger.v(message, error: error, stackTrace: stackTrace);
  }

  void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.wtf(message, error: error, stackTrace: stackTrace);
  }
}


// ℹ️ How to use in your app:
//
// import 'package:peekaboo/peekaboo.dart';
//
// final log = PeekabooLogger();
//
// log.d('Loading user profile...');
// log.w('API response time is slow');
// log.e('Something crashed', Exception('Test'), StackTrace.current);
