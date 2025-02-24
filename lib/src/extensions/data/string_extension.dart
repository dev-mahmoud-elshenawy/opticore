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
  /// String? nullableString = 'Mahmoud';
  /// print(nullableString.notNullOrEmpty); // Output: true
  /// ```
  bool get notNullOrEmpty => ((this ?? '').trim().isNotEmpty);

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
}

extension FormatExtension on String {
  /// Formats a numeric string into a price format with commas and removes trailing zeroes.
  ///
  /// Handles international price formats and ensures a clean output.
  /// Example:
  /// ```dart
  /// '1234567.00'.formatPrice; // Output: '1,234,567'
  /// ```
  String get formatPrice {
    if (isEmpty) return this;

    try {
      final List<String> parts = split('.');
      parts[0] = parts[0].replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match match) => '${match[1]},',
      );

      String result = parts.join('.');

      if (!result.contains('.')) return result;

      result = result.replaceAll(RegExp(r'0*$'), '');
      return result.endsWith('.')
          ? result.substring(0, result.length - 1)
          : result;
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

  /// Adds a Left-To-Right Mark (LRM) to the string to force Left-To-Right text direction.
  /// Returns the string with the LRM added at the beginning and end.
  /// If the string contains only English letters and numbers, it returns the string unchanged.
  ///
  /// This method is useful when displaying text that contains both Left-To-Right and Right-To-Left characters.
  ///
  /// Example:
  /// ```dart
  /// 'Hello مرحبا'.forceLTR; // Output: 'Hello ‎مرحبا‎'
  /// ```
  String get forceLTR {
    if (!notNullOrEmpty) return '';
    // Check if the string contains only English letters and numbers
    final RegExp englishRegExp = RegExp(r'^[A-Za-z0-9 \-/]+$');
    if (englishRegExp.hasMatch(this)) {
      const ltrMark = '\u200E'; // Left-To-Right Mark (LRM)
      return '$ltrMark$this$ltrMark';
    }
    return this; // Return the text unchanged if it doesn't contain only English letters and numbers
  }


  /// Adds a Left-To-Right Mark (LRM) and a plus sign to the string to force Left-To-Right text direction.
  /// Returns the string with the LRM added at the beginning and a plus sign.
  /// If the string contains only English letters and numbers, it returns the string unchanged.
  ///
  /// This method is useful when displaying phone numbers or other strings that start with a plus sign.
  ///
  /// Example:
  /// ```dart
  /// '+1234567890'.forceLTRWithPlus; // Output: '‎+1234567890'
  /// ```
  String get forceLTRWithPlus {
    if (trim().isEmpty) return '';
    // Check if the string contains only English letters, numbers, spaces, dashes or slashes.
    final RegExp englishRegExp = RegExp(r'^[A-Za-z0-9 \-/]+$');
    const ltrMark = '\u200E';
    if (englishRegExp.hasMatch(this)) {
      // Prepend LTR mark and a plus sign, then the number.
      return '$ltrMark+$this';
    }
    return '+$this';
  }

  /// Converts a string to **camelCase**.
  ///
  /// **Example:**
  /// ```dart
  /// 'hello world'.toCamelCase(); // Output: 'helloWorld'
  /// ```
  String get toCamelCase {
    final words = trim().split(RegExp(r'\s+'));
    if (words.isEmpty) return '';
    return words.first.toLowerCase() +
        words.skip(1).map((w) => w.capitalizeFirst).join();
  }

  /// Masks sensitive information such as **emails and phone numbers**.
  ///
  /// **Example:**
  /// ```dart
  /// 'user@example.com'.maskSensitiveInfo(); // Output: 'u***@example.com'
  /// '+1234567890'.maskSensitiveInfo(); // Output: '+1******890'
  /// ```
  String get maskSensitiveInfo {
    if (contains('@')) {
      final parts = split('@');
      return '${parts[0][0]}***@${parts[1]}';
    } else if (length >= 6) {
      return '${substring(0, 2)}******${substring(length - 2)}';
    }
    return this;
  }

  /// Trims the string to a maximum length, adding `...` if truncated.
  ///
  /// **Example:**
  /// ```dart
  /// 'Hello, this is a long text'.truncate(10); // Output: 'Hello, thi...'
  /// ```
  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}...';
  }

  /// Removes **all whitespace** from the string.
  ///
  /// **Example:**
  /// ```dart
  /// '  Hello World  '.removeWhitespace; // Output: 'HelloWorld'
  /// ```
  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');
}
