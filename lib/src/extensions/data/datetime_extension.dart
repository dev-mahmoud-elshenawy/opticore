part of '../extensions_import.dart';

/// Extension to add custom date formatting to `DateTime` objects.
///
/// This extension provides a method to format `DateTime` objects into a string
/// representation with the format `YYYY-MM-DD`. It allows you to easily display
/// dates in a consistent format throughout your application.
///
/// **Example usage:**
/// ```dart
/// DateTime now = DateTime.now();
/// print(now.formatDate); // Outputs the date in "YYYY-MM-DD" format, e.g., "2025-01-05"
/// ```
extension DateTimeFormatting on DateTime {
  /// Returns the date formatted as "YYYY-MM-DD".
  ///
  /// This method converts the `DateTime` object into a string representation
  /// in the format `YYYY-MM-DD`, ensuring that the month and day are always
  /// two digits (e.g., "05" instead of "5").
  String get formatDate {
    return "$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";
  }
}

/// Extension to add custom date parsing to `String` objects.
///
/// This extension provides a method to parse a string in the format `YYYY-MM-DD`
/// into a `DateTime` object. It ensures that each part (year, month, day) is
/// correctly padded for consistency. If parsing fails, it returns the current
/// `DateTime`.
extension DateTimeStringFormatting on String {
  /// Converts a string in the format `YYYY-MM-DD` to a [DateTime] object.
  ///
  /// Ensures that each part (year, month, day) is correctly padded for consistency.
  /// If parsing fails, returns the current [DateTime].
  /// Example:
  /// ```dart
  /// '2023-01-11'.formatDate; // Output: DateTime object for 2023-01-11
  /// ```
  DateTime get formatDate {
    try {
      final List<String> parts = split('-');

      String year = parts[0];
      String month = parts[1].padLeft(2, '0');
      String day = parts[2].padLeft(2, '0');

      String formattedDate = '$year-$month-$day';

      return DateTime.tryParse(formattedDate) ?? DateTime.now();
    } catch (_) {
      return DateTime.now();
    }
  }
}

/// Extension to add custom date parsing to nullable `String` objects.
///
/// This extension provides a method to parse a nullable string in the format `YYYY-MM-DD`
/// into a `DateTime` object. It ensures that each part (year, month, day) is
///
/// correctly padded for consistency. If parsing fails, it returns the current
/// `DateTime`.
extension DateTimeStringNullableFormatting on String? {
  /// Returns the string parsed as a DateTime, or `null` if it cannot be parsed.
  ///
  /// Example:
  /// ```dart
  /// String? dateString = '2023-01-11';
  /// DateTime? parsedDate = dateString.toDateTimeOrNull;
  /// print(parsedDate); // Output: DateTime object for 2023-01-11
  /// ```
  DateTime? get toDateTimeOrNull {
    if (this == null) return null;
    try {
      return DateTime.parse(this!);
    } catch (e) {
      return null;
    }
  }

  /// Returns the string parsed as a DateTime, or a default value if parsing fails.
  /// Default value is `DateTime.now()` unless specified.
  ///
  /// Example:
  /// ```dart
  /// String? dateString = '2023-01-11';
  /// DateTime parsedDate = dateString.toDateTimeOrDefault();
  /// print(parsedDate); // Output: DateTime object for 2023-01-11
  /// ```
  DateTime toDateTimeOrDefault([DateTime? defaultValue]) {
    return toDateTimeOrNull ?? (defaultValue ?? DateTime.now());
  }
}
