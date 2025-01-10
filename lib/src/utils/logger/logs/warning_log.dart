import 'package:talker/talker.dart';

/// This is a custom log that is used to log warning messages.
class WarningLog extends TalkerLog {
  WarningLog(super.message);

  @override
  AnsiPen get pen => AnsiPen()..yellow();

  @override
  String get title => 'WARNING';

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) =>
      '[$title] | $message$displayStackTrace';
}
