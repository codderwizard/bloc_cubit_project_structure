import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

var logger = MyLogger();

class MyLogger {
  /// Log a message at level verbose.
  void verbose(dynamic message) {
    _print("🔅 VERBOSE: $message");
  }

  /// Log a message at level debug.
  void debug(dynamic message) {
    _print("⚙️ DEBUG: $message");
  }

  /// Log a message at level info.
  void info(dynamic message) {
    _print("📣 INFO: $message");
  }

  /// Log a message at level warning.
  void warning(dynamic message) {
    _print("⚠️ WARNING: $message");
  }

  /// Log a message at level error.
  void error(dynamic message) {
    _print("⚠️ ERROR: $message");
  }

  void _print(dynamic message) {
    if (kDebugMode) {
      print("$message");
    }
  }

  void _log(dynamic message) {
    if (kDebugMode) {
      developer.log("$message");
    }
  }

  void log(dynamic message, {bool printFullText = false, StackTrace? stackTrace}) {
    if (printFullText) {
      _log(message);
    } else {
      _print(message);
    }
    if (stackTrace != null) {
      _print(stackTrace);
    }
  }
}
