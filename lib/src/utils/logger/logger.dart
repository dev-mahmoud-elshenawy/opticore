part of 'logger_import.dart';

/// The functions that you can use:-
///
/// • [warning] ➼ Log a new warning message
/// ```dart
///   ➡ Logger.warning('Log Warning');
/// ```
/// • [debug] ➼ Log a new debug message
/// ```dart
///   ➡ Logger.debug('Log Debug');
/// ```
/// • [error] ➼ Log a new error message
/// ```dart
///   ➡ Logger.error('Log Error');
/// ```
/// • [info] ➼ Log a new info message
/// ```dart
///   ➡ Logger.info('Log Info');
/// ```
/// • [good] ➼ Log a new good message
/// ```dart
///   ➡ Logger.good('Log Good');
/// ```
/// • [verbose] ➼ Log a new verbose message
/// ```dart
///   ➡ Logger.verbose('Log Verbose');
/// ```
/// • [critical] ➼ Log a new critical message
/// ```dart
///   ➡ Logger.critical('Log Critical');
/// ```
/// • [route] ➼ Log a new route message
/// ```dart
///   ➡ Logger.route(route: Route(), isPush: true);
/// ```
/// • [enable] ➼ The method will return everything back if the package was suspended by the [disable] method
/// ```dart
///   ➡ Logger.enable();
/// ```
/// • [disable] ➼ If you config package to handle errors or making logs, this method stop these processes
/// ```dart
///   ➡ Logger.disable();
/// ```
/// • [cleanHistory] ➼ Clear all log history
/// ```dart
///   ➡ Logger.cleanHistory();
/// ```
class Logger {
  static final Talker _talker = Talker();

  /// Log a new warning message
  static void warning(dynamic msg) {
    if (kDebugMode) {
      _talker.logCustom(
        WarningLog(
          msg.toString(),
        ),
      );
    }
  }

  /// Log a new debug message
  static void debug(dynamic msg) {
    if (kDebugMode) {
      _talker.logCustom(
        DebugLog(
          msg.toString(),
        ),
      );
    }
  }

  /// Log a new error message
  static void error(dynamic msg) {
    if (kDebugMode) {
      _talker.logCustom(
        ErrorLog(
          msg.toString(),
        ),
      );
    }
  }

  /// Log a new info message
  static void info(dynamic msg) {
    if (kDebugMode) {
      _talker.logCustom(
        InfoLog(
          msg.toString(),
        ),
      );
    }
  }

  /// Log a new good message
  static void good(dynamic msg) {
    if (kDebugMode) {
      _talker.logCustom(
        GoodLog(
          msg.toString(),
        ),
      );
    }
  }

  /// Log a new verbose message
  static void verbose(dynamic msg) {
    if (kDebugMode) {
      _talker.logCustom(
        VerboseLog(
          msg.toString(),
        ),
      );
    }
  }

  /// Log a new critical message
  static void critical(dynamic msg) {
    if (kDebugMode) {
      _talker.logCustom(
        CriticalLog(
          msg.toString(),
        ),
      );
    }
  }

  /// Log a new route message
  static void route({
    required Route route,
    bool isPush = true,
  }) {
    if (kDebugMode) {
      _talker.logCustom(
        RouteLog(
          route: route,
          isPush: isPush,
        ),
      );
    }
  }

  /// The method will return everything back if the package was suspended by the [disable] method
  static void enable() {
    if (kDebugMode) {
      _talker.enable();
    }
  }

  /// If you config package to handle errors or making logs, this method stop these processes
  static void disable() {
    if (kDebugMode) {
      _talker.disable();
    }
  }

  /// Clear all log history
  static void cleanHistory() {
    if (kDebugMode) {
      _talker.cleanHistory();
    }
  }
}
