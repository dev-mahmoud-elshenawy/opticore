import 'package:talker/talker.dart';

/// This is a custom log that is used to log info messages.
class InfoLog extends TalkerLog {
  InfoLog(super.message);

  @override
  AnsiPen get pen => AnsiPen()..blue();

  @override
  String get title => 'INFO';

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) =>
      '[$title] | $message$displayStackTrace';
}
