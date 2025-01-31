part of '../extensions_import.dart';

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

  /// Returns the string parsed as an integer, or a default value if it cannot be parsed.
  ///
  /// Default value is `0` unless specified.
  ///
  /// Example:
  /// ```dart
  /// String? number = '123';
  /// int parsedNumber = number.toIntOrDefault();
  /// print(parsedNumber); // Output: 123
  /// ```
  int toIntOrDefault([int defaultValue = 0]) {
    return toIntOrNull ?? defaultValue;
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

  /// Returns the string parsed as a double, or a default value if it cannot be parsed.
  ///
  /// Default value is `0.0` unless specified.
  ///
  /// Example:
  /// ```dart
  /// String? number = '123.45';
  /// double parsedNumber = number.toDoubleOrDefault();
  /// print(parsedNumber); // Output: 123.45
  /// ```
  double toDoubleOrDefault([double defaultValue = 0.0]) {
    return toDoubleOrNull ?? defaultValue;
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

  /// Returns the string parsed as a Map, or an empty map if parsing fails.
  ///
  /// Example:
  /// ```dart
  /// String? jsonMap = '{"name": "Mahmoud"}';
  /// Map<String, dynamic> parsedMap = jsonMap.toMapOrDefault;
  /// print(parsedMap); // Output: {name: Mahmoud}
  /// ```
  Map<String, dynamic> get toMapOrDefault {
    return toMapOrNull ?? {};
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

  /// Returns the string parsed as a List, or an empty list if parsing fails.
  ///
  /// Example:
  /// ```dart
  /// String? jsonList = '["Mahmoud", "Ali"]';
  /// List<String> parsedList = jsonList.toListOrDefault;
  /// print(parsedList); // Output: [Mahmoud, Ali]
  /// ```
  List<dynamic> get toListOrDefault {
    return toListOrNull ?? [];
  }

  /// Returns the string parsed as a boolean if possible, or `null` if it cannot be parsed.
  ///
  /// This method supports common boolean values such as 'true', 'false', '1', '0', 'yes', 'no', 'on', and 'off'.
  ///
  /// Example:
  /// ```dart
  /// String? boolString = 'true';
  /// bool? parsedBool = boolString.toBoolOrNull;
  /// print(parsedBool); // Output: true
  /// ```
  bool? get toBoolOrNull {
    if (this == null) return null;
    final lower = this!.toLowerCase();
    if (lower == 'true' || lower == '1' || lower == 'yes' || lower == 'on') {
      return true;
    } else if (lower == 'false' ||
        lower == '0' ||
        lower == 'no' ||
        lower == 'off') {
      return false;
    }
    return null;
  }

  /// Returns the string parsed as a boolean, or a default value if parsing fails.
  /// Default value is `false` unless specified.
  ///
  /// This method supports common boolean values such as 'true', 'false', '1', '0', 'yes', 'no', 'on', and 'off'.
  ///
  /// Example:
  /// ```dart
  /// String? boolString = 'true';
  /// bool parsedBool = boolString.toBoolOrDefault();
  /// print(parsedBool); // Output: true
  /// ```
  bool toBoolOrDefault([bool defaultValue = false]) {
    return toBoolOrNull ?? defaultValue;
  }

  /// Returns `true` if the string contains only numeric characters (Western or Arabic-Indic).
  ///
  /// This method supports both Western and Arabic-Indic numerals.
  ///
  /// Example:
  /// ```dart
  /// print('123'.isNumeric); // Output: true ✅ (Western)
  /// print('٤٥٦٧'.isNumeric); // Output: true ✅ (Arabic-Indic)
  /// print('١٢٣.٤٥'.isNumeric); // Output: true ✅ (Arabic-Indic with decimal)
  /// print('abc'.isNumeric); // Output: false ❌
  /// print('١٢٣abc'.isNumeric); // Output: false ❌ (Mixed)
  /// ```
  bool get isNumeric {
    if (this == null) return false;
    return RegExp(r'^[\d٠١٢٣٤٥٦٧٨٩]+(\.\d+)?$').hasMatch(this!);
  }

  /// Capitalizes the first letter of a string (if it's not Arabic or non-latin).
  ///
  /// Example:
  /// ```dart
  /// print('hello'.capitalize); // Output: 'Hello'
  /// print('مرحبا'.capitalize); // Output: 'مرحبا'
  /// ```
  String get capitalizeFirstOnly {
    if (this == null || this!.isEmpty) return '';

    String text = this!;

    // Check if the first character is Latin-based
    if (RegExp(r'^[a-zA-Z]').hasMatch(text)) {
      return text[0].toUpperCase() + text.substring(1);
    }

    // If non-latin, return string as is, or handle it as needed
    return text;
  }

  /// Capitalizes the **first letter of each word** in the string.
  ///
  /// **Example Usage:**
  /// ```dart
  /// "hello, how are you".capitalizeFirst; // Output: "Hello, How Are You"
  /// ```
  String get capitalizeFirst {
    if (this == null || this!.trim().isEmpty) return '';

    return this!
        .split(' ')
        .map((word) =>
            word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '')
        .join(' ');
  }
}
