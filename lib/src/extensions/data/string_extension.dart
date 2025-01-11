part of '../extensions_import.dart';

extension SafeString on String? {
  /// Ensures that the string is not null.
  ///
  /// If the string is null, it returns an empty string.
  /// Example:
  /// ```dart
  /// String? nullableString = null;
  /// print(nullableString.notNull); // Output: ''
  /// ```
  String get notNull => this ?? '';

  /// Checks if the string is not null and not empty.
  ///
  /// Returns `true` if the string has content, otherwise `false`.
  /// Example:
  /// ```dart
  /// String? nullableString = 'example';
  /// print(nullableString.notNullOrEmpty); // Output: true
  /// ```
  bool get notNullOrEmpty => ((this ?? '').trim().isNotEmpty);
}

extension FormatPriceExtension on String {
  /// Formats a numeric string into a price format with commas and removes trailing zeroes.
  ///
  /// Handles international price formats and ensures a clean output.
  /// Example:
  /// ```dart
  /// '1234567.00'.formatPrice; // Output: '1,234,567'
  /// ```
  String get formatPrice {
    if (isEmpty) {
      return this;
    }

    try {
      final List<String> parts = split('.');

      parts[0] = parts[0].replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match match) => '${match[1]},',
      );

      String? result = parts.join('.');

      if (!result.contains('.')) {
        return result;
      }

      result = result.replaceAll(RegExp(r'0*$'), '');
      if (result.endsWith('.')) {
        result = result.substring(0, result.length - 1);
      }

      return result;
    } catch (e) {
      Logger.debug('Error formatting price: $e');
      return this;
    }
  }

  /// Converts Arabic numeric characters to English numeric characters.
  ///
  /// Example:
  /// ```dart
  /// '١٢٣٤٥٦'.englishNumbers; // Output: '123456'
  /// ```
  String get englishNumbers {
    final Map<String, String> arabicToEnglishMap = {
      '١': '1',
      '٢': '2',
      '٣': '3',
      '٤': '4',
      '٥': '5',
      '٦': '6',
      '٧': '7',
      '٨': '8',
      '٩': '9',
      '٠': '0',
    };

    return splitMapJoin(
      RegExp('[٠-٩]'),
      onMatch: (Match match) => arabicToEnglishMap[match.group(0)]!,
      onNonMatch: (String nonMatch) => nonMatch,
    );
  }

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
