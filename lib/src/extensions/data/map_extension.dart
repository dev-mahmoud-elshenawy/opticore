part of '../extensions_import.dart';

/// Extension for safely accessing and manipulating values in a [Map<String, dynamic>].
///
/// This extension provides several utility methods to handle common use cases when
/// interacting with maps that may contain nullable or dynamic values. It includes:
/// - Safely retrieving a value with a custom parser function, providing a default value if the key is missing or the value is invalid.
/// - Safely retrieving a list of values, using a converter function for each list element.
/// - Adding a key-value pair to the map only if the value is not null.
///
/// **Example usage:**
/// ```dart
/// Map<String, dynamic> map = {'name': 'Alice', 'age': 25};
/// String name = map.safeValue(key: 'name', parser: (value) => value as String, defaultValue: 'Unknown');
/// List<int> ages = map.safeListValue(key: 'ages', converter: (value) => value as int);
/// map.addIfNotNull(key: 'city', value: 'New York');
/// ```
extension SafeMapAccess<M> on Map<String, dynamic> {
  /// Safely retrieves a value for the given key, applying an optional parser function.
  ///
  /// If the key exists in the map and the value is not null, it will be parsed
  /// using the provided [parser] function. If the value is null or the key is
  /// missing, it returns the [defaultValue]. If an error occurs during parsing,
  /// it logs the error and returns the [defaultValue].
  ///
  /// **Parameters:**
  /// - [key]: The key to look up in the map.
  /// - [parser]: An optional function to parse the value retrieved from the map.
  /// - [defaultValue]: A fallback value if the key is missing or parsing fails.
  ///
  /// **Returns:**
  /// - The parsed value if successful, or [defaultValue] in case of errors or null values.
  ///
  /// **Example:**
  /// ```dart
  /// Map<String, dynamic> map = {'age': 25};
  /// int age = map.safeValue(key: 'age', parser: (value) => value as int, defaultValue: 0);
  /// print(age); // Output: 25
  /// ```
  M safeValue({
    required String key,
    M Function(dynamic)? parser,
    dynamic defaultValue,
  }) {
    try {
      if (containsKey(key)) {
        dynamic value = this[key];
        if (parser != null && value != null) {
          return parser(value) ?? defaultValue;
        } else {
          return value as M;
        }
      } else {
        return defaultValue;
      }
    } catch (e) {
      Logger.debug('Error in Parsing safeValue: $e');
      return defaultValue;
    }
  }

  /// Safely retrieves a list of values for the given key, applying a converter function.
  ///
  /// If the key exists and the value is a list, each item in the list is converted
  /// using the [converter] function. If the key does not exist or the value is not a list,
  /// it returns an empty list. If an error occurs during the conversion, it logs the error
  /// and returns an empty list.
  ///
  /// **Parameters:**
  /// - [key]: The key to look up in the map.
  /// - [converter]: A function to convert each item in the list to the desired type.
  ///
  /// **Returns:**
  /// - A list of values after conversion, or an empty list if the key is missing or an error occurs.
  ///
  /// **Example:**
  /// ```dart
  /// Map<String, dynamic> map = {'numbers': [1, 2, 3]};
  /// List<int> numbers = map.safeListValue(key: 'numbers', converter: (value) => value as int);
  /// print(numbers); // Output: [1, 2, 3]
  /// ```
  List<T> safeListValue<T>({
    required String key,
    required T Function(dynamic) converter,
  }) {
    try {
      final List<dynamic>? list = this[key] as List<dynamic>?;

      if (list != null) {
        return list.map<T>(converter).toList();
      } else {
        return [];
      }
    } catch (e) {
      Logger.error('Error in Parsing safeListValue: $e with Key: $key');
      return [];
    }
  }

  /// Adds a key-value pair to the map only if the value is not null.
  ///
  /// This method ensures that a key-value pair is only added to the map if the
  /// value is not null. This is useful when working with dynamic or nullable
  /// values to avoid adding unnecessary null entries to the map.
  ///
  /// **Parameters:**
  /// - [key]: The key to add to the map.
  /// - [value]: The value to associate with the key.
  ///
  /// **Returns:**
  /// - None. The map is updated directly if the value is not null.
  void addIfNotNull({required String key, required dynamic value}) {
    if (value != null) {
      this[key] = value;
    }
  }
}
