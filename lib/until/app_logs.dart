import 'dart:developer';

import 'package:flutter/foundation.dart';

/// Log Color Enum
enum AnsiColor { red, yellow, green, reset }

/// Log Enum
enum LogLevel { info, warning, error, debug, wtf, success, fail, todo }

class AppLogs {
  // final String _reset = '\x1B[0m';
  static const String _red = '\x1B[31m';
  static const String _green = '\x1B[32m';
  static const String _yellow = '\x1B[33m';

  // final String _bold = '\x1B[1m';
  static const String _cyan = '\x1b[36m';

  // final String _purple = '\x1B[35m';
  static const String _pink = "\x1b[38;5;205m";

  /// Information Log with cyan color
  static void info(String message) {
    printTheMessage(
        color: _cyan,
        emoji: "⛅",
        message: message,
        logType: LogLevel.info.name);
  }

  /// Warning Log with yellow color
  static void warning(String message) {
    printTheMessage(
        color: _yellow,
        emoji: "🐢",
        message: message,
        logType: LogLevel.warning.name);
  }

  /// Error Log with red color
  static void error(String message) {
    printTheMessage(
        color: _red,
        emoji: "⛔",
        message: message,
        logType: LogLevel.error.name);
  }

  /// Success Log with green color
  static void success(String message) {
    printTheMessage(
        color: _green,
        emoji: "✅",
        message: message,
        logType: LogLevel.success.name);
  }

  /// Debug Log with yellow color
  static void debug(String message) {
    printTheMessage(
        color: _yellow,
        emoji: "🚧",
        message: message,
        logType: LogLevel.debug.name);
  }

  /// Log based on boolean and message
  static checkSuccess(bool isSuccess, String message) {
    if (isSuccess) {
      printTheMessage(
          color: _green, emoji: "✅", message: message, logType: "TRUE");
    } else {
      printTheMessage(
          color: _red, emoji: "❌", message: message, logType: "FALSE");
    }
  }

  /// Todo Log with pink Color
  static todo(String message) {
    printTheMessage(
        color: _pink,
        emoji: "📝",
        message: message,
        logType: LogLevel.todo.name);
  }

  /// Custom Log with your custom properties
  static void custom(
      {required String message,
      required String emoji,
      required String ansiColor,
      required String logType}) {
    printTheMessage(
        color: ansiColor, emoji: emoji, message: message, logType: logType);
  }
}

/// Print in color and emoji
printTheMessage(
    {String emoji = "✅",
    String message = "",
    String color = '\x1B[0m',
    String logType = "info"}) {
  if (kDebugMode) {
    String bold = '\x1B[1m';
    String normal = '\x1B[0m';
    String reset = '\x1B[0m';

    print('$color$bold --------------------------------------------------------------');

    print('$emoji $color$bold[${logType.toUpperCase()}]:$normal$color $message$reset');
    // print('$color$bold --------------------------------------------------------------');
  }
}











// // Dart imports:
// import 'dart:developer';
//
// // Flutter imports:
// import 'package:flutter/foundation.dart';
//
// // Project imports:
// import 'package:master_utility/src/log/stack_trace.dart';
//
// class LogHelper {
//   /// For disable log | For set variable use [setIsLogVisible] method in `` void main(){} ``
//   /// ```
//   /// bool isLogVisible = true;
//   /// ```
//   static bool _isLogVisible = true;
//   bool get isLogVisible => _isLogVisible;
//   static void setIsLogVisible({required bool isLogVisible}) {
//     _isLogVisible = isLogVisible;
//   }
//
//   static bool get _isReleaseMode => !kReleaseMode;
//
//   /// SHOW LOG INFO
//   static void logInfo(dynamic msg, {StackTrace? stackTrace}) {
//     if (_isReleaseMode) {
//       if (stackTrace != null) {
//         if (_isLogVisible) {
//           CustomTrace programInfo = CustomTrace(stackTrace);
//           log('\x1B[94m ${[programInfo.fileName]} ${[
//             programInfo.functionName
//           ]} at ${programInfo.lineNumber} | $msg\x1B[0m');
//         }
//       } else {
//         log('\x1B[94m $msg\x1B[0m');
//       }
//     }
//   }
//
//   /// [logSuccess] print Green Color
//   static void logSuccess(dynamic msg, {StackTrace? stackTrace}) {
//     if (_isReleaseMode) {
//       if (stackTrace != null) {
//         if (_isLogVisible) {
//           CustomTrace programInfo = CustomTrace(stackTrace);
//           log('\x1B[92m ${[programInfo.fileName]} ${[
//             programInfo.functionName
//           ]} at ${programInfo.lineNumber} | $msg\x1B[0m');
//         }
//       } else {
//         if (_isReleaseMode) log('\x1B[92m$msg\x1B[0m');
//       }
//     }
//   }
//
//   /// [logWarning] print Yellow Color
//   static void logWarning(dynamic msg, {StackTrace? stackTrace}) {
//     if (_isReleaseMode) {
//       if (stackTrace != null) {
//         if (_isLogVisible) {
//           CustomTrace programInfo = CustomTrace(stackTrace);
//           log('\x1B[33m ${[programInfo.fileName]} ${[
//             programInfo.functionName
//           ]} at ${programInfo.lineNumber} | $msg\x1B[0m');
//         }
//       } else {
//         if (_isReleaseMode) log('\x1B[33m$msg\x1B[0m');
//       }
//     }
//   }
//
//   /// [logError] print Red Color
//   static void logError(dynamic msg, {StackTrace? stackTrace}) {
//     if (_isReleaseMode) {
//       if (stackTrace != null) {
//         if (_isLogVisible) {
//           CustomTrace programInfo = CustomTrace(stackTrace);
//           log('\x1B[91m ${[programInfo.fileName]} ${[
//             programInfo.functionName
//           ]} at ${programInfo.lineNumber} | $msg\x1B[0m');
//         }
//       } else {
//         if (_isReleaseMode) log('\x1B[91m$msg\x1B[0m');
//       }
//     }
//   }
//
//   /// [logCyan] print Cyan Color
//   static void logCyan(dynamic msg, {StackTrace? stackTrace}) {
//     if (_isReleaseMode) {
//       if (stackTrace != null) {
//         if (_isLogVisible) {
//           CustomTrace programInfo = CustomTrace(stackTrace);
//           log('\x1B[36m ${[programInfo.fileName]} ${[
//             programInfo.functionName
//           ]} at ${programInfo.lineNumber} | $msg\x1B[0m');
//         }
//       } else {
//         if (_isReleaseMode) log('\x1B[36m$msg\x1B[0m');
//       }
//     }
//   }
// }