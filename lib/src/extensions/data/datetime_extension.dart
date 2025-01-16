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
