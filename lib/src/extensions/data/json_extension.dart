part of '../extensions_import.dart';

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

  /// Checks if the string is a valid JSON string.
  /// Returns `true` if the string is a valid JSON string, otherwise `false`.
  ///
  /// Example:
  /// ```dart
  /// String? jsonString = '{"name": "Mahmoud"}';
  /// print(jsonString.isValidJson); // Output: true
  /// ```
  bool get isValidJson {
    if (this == null || this!.isEmpty) return false;
    try {
      jsonDecode(this!);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Safely decodes a JSON string into a dynamic object with a default value.
  /// Returns the decoded JSON object if the string is non-null, non-empty, and can be successfully decoded.
  /// If the string is null, empty, or invalid, it returns the provided default value.
  ///
  /// Example:
  /// ```dart
  /// String? jsonString = '{"name": "Mahmoud"}';
  /// Map<String, dynamic> defaultValue = {};
  /// Map<String, dynamic> decoded = jsonString.safeJsonDecodeWithDefault(defaultValue);
  /// print(decoded); // Output: {name: Mahmoud}
  /// ```
  T safeJsonDecodeWithDefault<T>(T defaultValue) {
    if (this == null || this!.isEmpty) return defaultValue;
    try {
      final decoded = jsonDecode(this!);
      if (decoded is T) {
        return decoded;
      } else {
        Logger.error('Decoded JSON does not match the expected type: $T');
        return defaultValue;
      }
    } catch (e) {
      Logger.error('Error decoding JSON string: $e');
      return defaultValue;
    }
  }

  /// Safely decodes a JSON string into a Map<String, dynamic> object.
  /// Returns the decoded JSON object if the string is non-null, non-empty, and can be successfully decoded.
  /// If the string is null, empty, or invalid, it returns `null`.
  ///
  /// Example:
  /// ```dart
  /// String? jsonString = '{"name": "Mahmoud"}';
  /// Map<String, dynamic>? decoded = jsonString.safeJsonDecodeAsMap;
  /// print(decoded); // Output: {name: Mahmoud}
  /// ```
  Map<String, dynamic>? get safeJsonDecodeAsMap {
    if (this == null || this!.isEmpty) return null;
    try {
      final decoded = jsonDecode(this!);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      } else {
        Logger.error('Decoded JSON is not a Map: $this');
        return null;
      }
    } catch (e) {
      Logger.error('Error decoding JSON string as Map: $e');
      return null;
    }
  }

  /// Safely decodes a JSON string into a List<dynamic> object.
  /// Returns the decoded JSON object if the string is non-null, non-empty, and can be successfully decoded.
  List<dynamic>? get safeJsonDecodeAsList {
    if (this == null || this!.isEmpty) return null;
    try {
      final decoded = jsonDecode(this!);
      if (decoded is List<dynamic>) {
        return decoded;
      } else {
        Logger.error('Decoded JSON is not a List: $this');
        return null;
      }
    } catch (e) {
      Logger.error('Error decoding JSON string as List: $e');
      return null;
    }
  }

  /// Pretty prints the JSON string with indentation.
  /// Returns the formatted JSON string if the string is non-null, non-empty, and can be successfully decoded.
  ///
  /// Example:
  /// ```dart
  /// String? jsonString = '{"name": "Mahmoud"}';
  /// String? prettyPrinted = jsonString.prettyPrintJson;
  /// print(prettyPrinted); // Output: {
  /// //   "name": "Mahmoud"
  /// // }
  /// ```
  String? get prettyPrintJson {
    if (this == null || this!.isEmpty) return null;
    try {
      final decoded = jsonDecode(this!);
      return JsonEncoder.withIndent('  ').convert(decoded);
    } catch (e) {
      Logger.error('Error pretty printing JSON string: $e');
      return null;
    }
  }

  /// Safely decodes a JSON string into an object of type `T`.
  /// Returns the decoded JSON object if the string is non-null, non-empty, and can be successfully decoded.
  ///
  /// The [fromJson] function is used to convert the decoded JSON map into an object of type `T`.
  /// If the string is null, empty, or invalid, it returns `null`.
  ///
  /// Example:
  /// ```dart
  /// String? jsonString = '{"name": "Mahmoud"}';
  /// User? user = jsonString.safeJsonDecodeToObject(User.fromJson);
  /// print(user?.name); // Output: Mahmoud
  /// ```
  T? safeJsonDecodeToObject<T>(T Function(Map<String, dynamic>) fromJson) {
    if (this == null || this!.isEmpty) return null;
    try {
      final decoded = jsonDecode(this!);
      if (decoded is Map<String, dynamic>) {
        return fromJson(decoded);
      } else {
        Logger.error('Decoded JSON is not a valid Map: $this');
        return null;
      }
    } catch (e) {
      Logger.error('Error decoding JSON string to object: $e');
      return null;
    }
  }

  /// Safely decodes a JSON string into an object of type `T`.
  /// Returns the decoded JSON object if the string is non-null, non-empty, and can be successfully decoded.
  ///
  /// The [fromJson] function is used to convert the decoded JSON map into an object of type `T`.
  /// If the string is null, empty, or invalid, it returns the provided default value.
  ///
  /// Example:
  /// ```dart
  /// String? jsonString = '{"name": "Mahmoud", "age": 30}';
  /// String? name = jsonString.safeJsonDecodeKey<String>('name');
  /// String? invalidKey = jsonString.safeJsonDecodeKey<String>('invalid');
  ///
  /// print(name); // Output: Mahmoud
  /// print(invalidKey); // Output: null (Key not found)
  /// ```
  T? safeJsonDecodeKey<T>(String key) {
    if (this == null || this!.isEmpty) return null;
    try {
      final decoded = jsonDecode(this!);
      if (decoded is Map<String, dynamic> && decoded.containsKey(key)) {
        return decoded[key] as T?;
      } else {
        Logger.error('Key "$key" not found in the decoded JSON.');
        return null;
      }
    } catch (e) {
      Logger.error('Error decoding JSON string: $e');
      return null;
    }
  }

  /// Safely decodes a nested JSON string into an object of type `T`.
  /// Returns the decoded JSON object if the string is non-null, non-empty, and can be successfully decoded.
  ///
  /// The [keys] parameter is a list of keys that represent the nested structure of the JSON object.
  ///
  /// Example:
  /// ```dart
  /// String? jsonString = '{"user": {"name": "Mahmoud", "age": 30}}';
  /// String? name = jsonString.safeJsonDecodeNested<String>(['user', 'name']);
  /// print(name); // Output: Mahmoud
  /// ```
  T? safeJsonDecodeNested<T>(List<String> keys) {
    if (this == null || this!.isEmpty) return null;
    try {
      var decoded = jsonDecode(this!);
      for (var key in keys) {
        if (decoded is Map<String, dynamic> && decoded.containsKey(key)) {
          decoded = decoded[key];
        } else {
          Logger.error('Key "$key" not found in the decoded JSON.');
          return null;
        }
      }
      return decoded as T?;
    } catch (e) {
      Logger.error('Error decoding JSON string: $e');
      return null;
    }
  }

  /// Safely decodes a JSON string into a list of objects of type `T`.
  /// Returns the decoded JSON object if the string is non-null, non-empty, and can be successfully decoded.
  /// If the string is null, empty, or invalid, it returns `null`.
  ///
  /// The [fromJson] function is used to convert each item in the decoded JSON list into an object of type `T`.
  ///
  /// Example:
  /// ```dart
  /// String? jsonString = '[{"name": "Mahmoud"}, {"name": "Ali"}]';
  /// List<User>? users = jsonString.safeJsonDecodeToListObjects(User.fromJson);
  /// print(users?.map((user) => user.name)); // Output: (Mahmoud, Ali)
  /// ```
  List<T>? safeJsonDecodeToListObjects<T>(
      T Function(Map<String, dynamic>) fromJson) {
    if (this == null || this!.isEmpty) return null;
    try {
      final decoded = jsonDecode(this!);
      if (decoded is List) {
        return decoded.map((e) => fromJson(e as Map<String, dynamic>)).toList();
      } else {
        Logger.error('Decoded JSON is not a list: $this');
        return null;
      }
    } catch (e) {
      Logger.error('Error decoding JSON string to list of objects: $e');
      return null;
    }
  }
}
