part of '../extensions_import.dart';

/// Extension on [Map<String, dynamic>] to safely retrieve values while handling
/// missing keys, null values, and type mismatches gracefully.
///
/// Provides generic and type-specific methods to extract values safely from JSON.
extension SafeMapAccess on Map<String, dynamic> {
  /// Retrieves a value of type [T] from the map using the specified [key].
  ///
  /// - If the key is missing, returns the [defaultValue] (if provided) or throws an exception.
  /// - If the key exists but is `null`, returns the [defaultValue].
  /// - If a [parser] function is provided, it attempts to convert the value.
  /// - Logs a warning if there is a type mismatch.
  ///
  /// Parameters:
  /// - [T]: The type of the value to retrieve.
  /// - [key]: The key to retrieve from the map.
  /// - [parser]: A function to parse the value to type [T].
  ///
  /// Example usage:
  /// ```dart
  /// int age = json.safeValue('age', parser: int.tryParse, defaultValue: 0);
  /// Model user = json.safeValue('user', parser: (val) => Model.fromJson(val));
  /// ```
  T safeValue<T>({
    required String key,
    T Function(dynamic)? parser,
    T? defaultValue,
  }) {
    try {
      if (!containsKey(key) || this[key] == null) {
        return defaultValue ?? (throw Exception("Missing key '$key'"));
      }

      final dynamic value = this[key];

      if (parser != null) {
        try {
          final parsedValue = parser(value);
          return parsedValue;
        } catch (e, stackTrace) {
          Logger.error(
              "Error parsing key '$key' with parser: $e \n$stackTrace");
        }
      }

      if (value is T) {
        return value;
      }

      Logger.debug(
        "Type mismatch for key '$key'. Expected ${T.toString()}, but found ${value.runtimeType}",
      );
    } catch (e, stackTrace) {
      Logger.error("Error retrieving key '$key': $e \n$stackTrace");
    }

    return defaultValue as T;
  }

  /// Retrieves an object of type [T] from the map using the specified [key].
  ///
  /// - If the key is missing, returns the [defaultValue] (if provided) or `null`.
  /// - If the key exists but is `null`, returns the [defaultValue].
  /// - If the value is a map, it is parsed using the provided [parser] function.
  /// - Logs a warning if there is a type mismatch.
  ///
  /// Parameters:
  /// - [T]: The type of the object to retrieve.
  /// - [key]: The key to retrieve from the map.
  /// - [parser]: A function to parse the map to type [T].
  ///
  /// Example usage:
  /// ```dart
  /// Model user = json.safeObject('user', parser: (val) => Model.fromJson(val));
  /// ```
  T? safeObject<T>({
    required String key,
    required T Function(Map<String, dynamic>) parser,
    T? defaultValue,
  }) {
    try {
      final value = this[key];
      if (value is Map<String, dynamic>) {
        return parser(value);
      }
    } catch (e, stackTrace) {
      Logger.error("Error parsing object for key '$key': $e\n$stackTrace");
    }
    return defaultValue;
  }

  /// Retrieves a **list** of type [T] from the map.
  ///
  /// - Accepts a [converter] function to transform items.
  /// - Returns an empty list `[]` if parsing fails.
  ///
  /// Parameters:
  /// - [key]: The key to retrieve from the map.
  /// - [converter]: A function to convert items to type [T].
  ///
  /// Example usage:
  /// ```dart
  /// List<String> tags = json.safeList<String>('tags', converter: (val) => val.toString());
  /// List<int> ids = json.safeList<int>('ids', converter: (val) => int.tryParse(val));
  /// List<Model> models = json.safeList<Model>('models', converter: (val) => Model.fromJson(val));
  /// List<dynamic> items = json.safeList<dynamic>('items');
  /// ```
  List<T> safeList<T>(String key, {T Function(dynamic)? parser}) {
    return safeValue<List<T>>(
      key: key,
      parser: (val) {
        if (val is List) {
          return parser != null
              ? val.map((e) => parser(e)).whereType<T>().toList()
              : val.cast<T>();
        }
        return [];
      },
      defaultValue: [],
    );
  }

  /// Retrieves an **integer** value from the map.
  ///
  /// - Parses the value using `int.tryParse()` if needed.
  /// - Returns the [defaultValue] if parsing fails.
  ///
  /// Parameters:
  /// - [key]: The key to retrieve from the map.
  /// - [defaultValue]: The value to return if the key is missing or parsing fails.
  ///  Defaults to `0`.
  ///
  /// Example usage:
  /// ```dart
  /// int userId = json.safeInt('id');
  /// ```
  int safeInt(String key, {int defaultValue = 0}) {
    return safeValue<int>(
      key: key,
      parser: (val) => int.tryParse(val.toString()) ?? defaultValue,
      defaultValue: defaultValue,
    );
  }

  /// Retrieves a **double** value from the map.
  ///
  /// - Parses the value using `double.tryParse()` if needed.
  /// - Returns the [defaultValue] if parsing fails.
  ///
  /// Parameters:
  /// - [key]: The key to retrieve from the map.
  /// - [defaultValue]: The value to return if the key is missing or parsing fails.
  /// Defaults to `0.0`.
  ///
  /// Example usage:
  /// ```dart
  /// double price = json.safeDouble('price');
  /// ```
  double safeDouble(String key, {double defaultValue = 0.0}) {
    return safeValue<double>(
      key: key,
      parser: (val) => double.tryParse(val.toString()) ?? defaultValue,
      defaultValue: defaultValue,
    );
  }

  /// Retrieves a **boolean** value from the map.
  ///
  /// - Accepts boolean, integer (1/0), and string ('true'/'false').
  /// - Returns the [defaultValue] if conversion fails.
  ///
  /// Parameters:
  /// - [key]: The key to retrieve from the map.
  /// - [defaultValue]: The value to return if the key is missing or parsing fails.
  /// Defaults to `false`.
  ///
  /// Example usage:
  /// ```dart
  /// bool isActive = json.safeBool('isActive');
  /// ```
  bool safeBool(String key, {bool defaultValue = false}) {
    return safeValue<bool>(
      key: key,
      parser: (val) {
        if (val is bool) return val;
        if (val is int) return val == 1;
        if (val is String) return val.toLowerCase() == 'true';
        return defaultValue;
      },
      defaultValue: defaultValue,
    );
  }

  /// Retrieves a **string** value from the map.
  ///
  /// - Converts any type to a string using `.toString()`.
  /// - Returns the [defaultValue] if the key is missing.
  ///
  /// Parameters:
  /// - [key]: The key to retrieve from the map.
  /// - [defaultValue]: The value to return if the key is missing.
  /// Defaults to an empty string `''`.
  ///
  /// Example usage:
  /// ```dart
  /// String username = json.safeString('name', defaultValue: 'Guest');
  /// ```
  String safeString(String key, {String defaultValue = ''}) {
    return safeValue<String>(
      key: key,
      parser: (val) => val.toString(),
      defaultValue: defaultValue,
    );
  }

  /// Adds a key-value pair to the map only if the value is not null, empty,
  /// and meets the custom condition (if provided).
  ///
  /// - If the value is `null`, an empty string, an empty list, or an empty map,
  ///   the key is not added.
  /// - The value is added only if it passes the optional provided custom condition.
  ///
  ///
  /// Example usage:
  /// ```dart
  /// myMap.addIfNotNull(key: 'name', value: someValue, condition: name.length > 3);
  /// myMap.addIfNotNull(key: 'age', value: age, condition: age > 18);
  /// ```
  void addIfNotNull({
    required String key,
    required dynamic value,
    bool? condition,
  }) {
    if (value != null &&
        (value is String ? value.isNotEmpty : value is! String) &&
        (value is List ? value.isNotEmpty : value is! List) &&
        (value is Map ? value.isNotEmpty : value is! Map) &&
        (condition ?? true)) {
      this[key] = value;
    }
  }
}

extension SafeMapExtensions on Map<String, dynamic>? {
  /// Retrieves a deeply nested value using dot notation.
  ///
  /// **Example:**
  /// ```dart
  /// Map<String, dynamic> json = {"user": {"profile": {"name": "Mahmoud"}}};
  /// print(json.safeGetNested("user.profile.name"));  // Outputs: "Mahmoud"
  /// ```
  dynamic safeGetNested(String path, {dynamic defaultValue}) {
    if (this == null) return defaultValue;

    return path.split('.').fold<dynamic>(this, (prev, key) {
      if (prev is Map<String, dynamic>) {
        return prev[key];
      }
      return defaultValue;
    });
  }

  /// Safely retrieves a value from a map using the provided [key], returning a default value if not found.
  /// If the map itself is `null`, it returns the default value.
  ///
  /// **Example:**
  /// ```dart
  /// Map<String, dynamic> user = {"name": "Mahmoud"};
  /// print(user.safeGet("name"));  // Outputs: "Mahmoud"
  /// print(user.safeGet("age", defaultValue: 25));  // Outputs: 25
  /// ```
  dynamic safeGet(String key, {dynamic defaultValue}) {
    if (this == null) return defaultValue;

    return this![key] ?? defaultValue;
  }

  /// Deep merges another map into this map, prioritizing non-null values.
  ///
  /// **Example:**
  /// ```dart
  /// Map<String, dynamic>? base = {"name": "Alice", "age": 25};
  /// Map<String, dynamic> updates = {"age": 30, "city": "New York"};
  /// print(base.deepMerge(updates));  // Outputs: {"name": "Alice", "age": 30, "city": "New York"}
  /// ```
  Map<String, dynamic> deepMerge(Map<String, dynamic> updates) {
    final newMap = Map<String, dynamic>.from(this ?? {});
    updates.forEach((key, value) {
      if (value != null) {
        newMap[key] = value;
      }
    });
    return newMap;
  }
}

/// Helper Extension to convert List<MapEntry<K, V>> into a Map<K, V>.
extension MapEntryListHelper<K, V> on Iterable<MapEntry<K, V>> {
  /// Converts a list of `MapEntry<K, V>` into a `Map<K, V>`.
  ///
  /// **Example:**
  /// ```dart
  /// List<MapEntry<String, int>> entries = [MapEntry('a', 1), MapEntry('b', 2)];
  /// Map<String, int> map = entries.toMap();
  /// print(map); // Output: {a: 1, b: 2}
  /// ```
  Map<K, V> toMap() => {for (var entry in this) entry.key: entry.value};
}
