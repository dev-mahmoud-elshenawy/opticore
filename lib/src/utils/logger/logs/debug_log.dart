import 'package:talker/talker.dart';

/// This is a custom log that is used to log debug messages.
class DebugLog extends TalkerLog {
  DebugLog(super.message);

  @override
  AnsiPen get pen => AnsiPen()..white();

  @override
  String get title => 'DEBUG';

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) =>
      '[$title] | $message$displayStackTrace';
}
