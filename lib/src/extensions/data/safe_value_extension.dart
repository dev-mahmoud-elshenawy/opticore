part of '../extensions_import.dart';

/// Extension on any type [M] that provides utility methods for handling non-null values.
///
/// This extension introduces methods to handle nullable values and ensures that non-null values
/// are used wherever applicable. It works with various data structures like variables, lists, and maps.
/// The extension methods are designed to safely manage nullable values by returning a default value
/// or updating variables only when the new value is non-null.
///
/// **Example usage:**
/// ```dart
/// final String name = "Mahmoud";
/// print(name.setNonNull(null)); // Outputs: "Mahmoud"
/// ```
///
/// The extension provides methods to:
/// - Safely return non-null values
/// - Update variables with non-null values
/// - Filter lists to include only non-null values

extension SetNonNullExtension<M> on M {
  /// Returns the non-null value if available, otherwise returns the instance itself.
  ///
  /// This method checks if a given value is null. If it's not null, it returns the value;
  /// otherwise, it returns the instance of the type [M] that the extension was applied on.
  ///
  /// **Example:**
  /// ```dart
  /// String? name = null;
  /// print(name.setNonNull("Mahmoud"));  // Outputs: "Mahmoud"
  /// ```
  M orDefault(M defaultValue) {
    return this ?? defaultValue;
  }

  /// Returns `null` if the current value matches the provided [fallbackValue], otherwise returns itself.
  ///
  /// Useful for avoiding default values being misused in further logic.
  ///
  /// **Example:**
  /// ```dart
  /// String? name = "";
  /// print(name.nullIfEquals(""));  // Outputs: null
  /// ```
  M? nullIfEquals(M fallbackValue) {
    return this == fallbackValue ? null : this;
  }
}

extension SafeParsingExtensions on dynamic {
  /// Converts the value to an integer, returning `defaultValue` if conversion fails.
  ///
  /// **Example:**
  /// ```dart
  /// print("123".toSafeInt());  // Outputs: 123
  /// print("abc".toSafeInt(defaultValue: 0));  // Outputs: 0
  /// print(3.7.toSafeInt());  // Outputs: 3
  /// ```
  int toSafeInt({int defaultValue = 0}) {
    if (this == null) return defaultValue;

    if (this is int) return this as int;
    if (this is double) {
      return (this as double).toInt(); // Handle double conversion
    }
    if (this is num) return (this as num).toInt();
    if (this is String) return int.tryParse(this.trim()) ?? defaultValue;

    return defaultValue;
  }

  /// Converts the value to a boolean, handling cases like "true", "false", 1, and 0.
  ///
  /// **Example:**
  /// ```dart
  /// print("true".toSafeBool());  // Outputs: true
  /// print(1.toSafeBool());  // Outputs: true
  /// print(0.toSafeBool());  // Outputs: false
  /// print("false".toSafeBool());  // Outputs: false
  /// print("random".toSafeBool());  // Outputs: false
  /// ```
  bool toSafeBool({bool defaultValue = false}) {
    if (this == null) return defaultValue;

    if (this is bool) return this as bool;
    if (this is int) return this == 1;
    if (this is String) {
      final lowerCase = this.trim().toLowerCase();
      if (lowerCase == 'true') return true;
      if (lowerCase == 'false') return false;
    }

    return defaultValue;
  }

  /// Converts the value to a double, returning `defaultValue` if conversion fails.
  ///
  /// **Example:**
  /// ```dart
  /// print("3.14".toSafeDouble());  // Outputs: 3.14
  /// print("abc".toSafeDouble(defaultValue: 0.0));  // Outputs: 0.0
  /// print(5.toSafeDouble());  // Outputs: 5.0
  /// ```
  double toSafeDouble({double defaultValue = 0.0}) {
    if (this == null) return defaultValue;

    if (this is double) return this as double;
    if (this is int) {
      return (this as int).toDouble(); // Handle integer conversion
    }
    if (this is num) return (this as num).toDouble();
    if (this is String) return double.tryParse(this.trim()) ?? defaultValue;

    return defaultValue;
  }
}
