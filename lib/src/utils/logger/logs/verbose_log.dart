import 'package:talker/talker.dart';

/// This is a custom log that is used to log verbose messages.
class VerboseLog extends TalkerLog {
  VerboseLog(super.message);

  @override
  AnsiPen get pen => AnsiPen()..gray();

  @override
  String get title => 'VERBOSE';

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) =>
      '[$title] | $message$displayStackTrace';
}
