import 'package:talker/talker.dart';

/// This is a custom log that is used to log critical messages.
class CriticalLog extends TalkerLog {
  CriticalLog(super.message);

  @override
  AnsiPen get pen => AnsiPen()..xterm(160);

  @override
  String get title => 'CRITICAL';

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) =>
      '[$title] | $message$displayStackTrace';
}
