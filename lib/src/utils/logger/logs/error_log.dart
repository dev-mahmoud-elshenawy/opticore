import 'package:talker/talker.dart';

/// This is a custom log that is used to log debug messages.
class ErrorLog extends TalkerLog {
  ErrorLog(super.message);

  @override
  AnsiPen get pen => AnsiPen()..red();

  @override
  String get title => 'ERROR';

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) =>
      '[$title] | $message$displayStackTrace';
}
