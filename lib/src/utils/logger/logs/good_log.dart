import 'package:talker/talker.dart';

/// This is a custom log that is used to log good messages.
class GoodLog extends TalkerLog {
  GoodLog(super.message);

  @override
  AnsiPen get pen => AnsiPen()..green();

  @override
  String get title => 'GOOD';

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) =>
      '[$title] | $message$displayStackTrace';
}
