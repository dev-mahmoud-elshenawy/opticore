import 'package:flutter/material.dart';
import 'package:talker/talker.dart';

/// This is a custom log that is used to log route messages.
class RouteLog extends TalkerLog {
  final Route route;

  RouteLog({
    required this.route,
    bool isPush = true,
  }) : super(_createMessage(route, isPush));

  @override
  AnsiPen get pen => AnsiPen()..cyan();

  @override
  String get title => route.settings.name ?? 'Route';

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) =>
      '[$title] | $message$displayStackTrace';

  static String _createMessage(
    Route<dynamic> route,
    bool isPush,
  ) {
    final buffer = StringBuffer();
    buffer.write(isPush ? 'Open' : 'Close');
    buffer.write(' Route Named: ');
    buffer.write(route.settings.name ?? 'NULL');

    final args = route.settings.arguments;
    if (args != null) {
      buffer.write('\nArguments: $args');
    }
    return buffer.toString();
  }
}
