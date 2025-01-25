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

  /// Set another value if string is null or empty.
  ///
  /// If the string is not null and not empty, it returns the string itself.
  /// Otherwise, it returns the provided value.
  /// Example:
  /// ```dart
  /// String? nullableString = null;
  /// print(nullableString.orSet('Mahmoud')); // Output: 'Mahmoud'
  /// ```
  String orSet(String value) {
    return notNullOrEmpty ? this! : value;
  }

  /// Checks if the string is not null and not empty.
  ///
  /// Returns `true` if the string has content, otherwise `false`.
  /// Example:
  /// ```dart
  /// String? nullableString = 'Mahmoud';
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

extension SafeJsonDecode on String? {
  /// Safely decodes a JSON string into a dynamic object
  /// Returns the decoded JSON object if the string is non-null, non-empty, and can be successfully decoded.
  /// If the string is null, empty, or invalid, it returns `null`.
  ///
  /// Example:
  /// ```dart
  /// String? jsonString = '{"name": "Mahmoud"}';
  /// dynamic? decoded = jsonString.safeJsonDecode;
  /// print(decoded); // Output: {name: Mahmoud}
  /// ```
  T? safeJsonDecode<T>() {
    if (this == null || this!.isEmpty) return null;
    try {
      final decoded = jsonDecode(this!);
      if (decoded is T) {
        return decoded;
      } else {
        Logger.error('Decoded JSON does not match the expected type: $T');
        return null;
      }
    } catch (e) {
      Logger.error('Error decoding JSON string: $e');
      return null;
    }
  }

  /// Safely encodes the object to a JSON string.
  /// Returns `null` if the object cannot be encoded.
  ///
  /// Example:
  /// ```dart
  /// Map<String, dynamic> map = {'name': 'Mahmoud'};
  /// String? jsonString = map.safeJsonEncode;
  /// print(jsonString); // Output: {"name":"Mahmoud"}
  /// ```
  String? get safeJsonEncode {
    try {
      return jsonEncode(this);
    } catch (e) {
      Logger.error('Error encoding JSON: $e');
      return null;
    }
  }
}

extension StringParsingExtensions on String? {
  /// Returns the string parsed as an integer if possible, or `null` if it cannot be parsed.
  ///
  /// Example:
  /// ```dart
  /// String? number = '123';
  /// int? parsedNumber = number.toIntOrNull;
  /// print(parsedNumber); // Output: 123
  /// ```
  int? get toIntOrNull {
    if (this == null) return null;
    try {
      return int.parse(this!);
    } catch (e) {
      return null;
    }
  }

  /// Returns the string parsed as a double if possible, or `null` if it cannot be parsed.
  ///
  /// Example:
  /// ```dart
  /// String? number = '123.45';
  /// double? parsedNumber = number.toDoubleOrNull;
  /// print(parsedNumber); // Output: 123.45
  /// ```
  double? get toDoubleOrNull {
    if (this == null) return null;
    try {
      return double.parse(this!);
    } catch (e) {
      return null;
    }
  }

  /// Returns the string parsed as a Map if it's a valid JSON map, or `null` if it's invalid.
  ///
  /// Example:
  /// ```dart
  /// String? jsonMap = '{"name": "Mahmoud"}';
  /// Map<String, dynamic>? parsedMap = jsonMap.toMapOrNull;
  /// print(parsedMap); // Output: {name: Mahmoud}
  /// ```
  Map<String, dynamic>? get toMapOrNull {
    if (this == null) return null;
    try {
      return jsonDecode(this!) as Map<String, dynamic>?;
    } catch (e) {
      return null;
    }
  }

  /// Returns the string parsed as a List if it's a valid JSON list, or `null` if it's invalid.
  ///
  /// Example:
  /// ```dart
  /// String? jsonList = '["Mahmoud", "Ali"]';
  /// List<String>? parsedList = jsonList.toListOrNull;
  /// print(parsedList); // Output: [Mahmoud, Ali]
  /// ```
  List<dynamic>? get toListOrNull {
    if (this == null) return null;
    try {
      return jsonDecode(this!) as List<dynamic>?;
    } catch (e) {
      return null;
    }
  }
}
