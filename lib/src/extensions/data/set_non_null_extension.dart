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
  M setNonNull(M? value) {
    return value ?? this;
  }

  /// A method to update the value of a target variable, works in the context of Lists and Maps.
  ///
  /// This method ensures that the target variable is updated with a new value only if the
  /// new value is non-null. If the provided value is null, the target variable remains unchanged.
  ///
  /// **Example:**
  /// ```dart
  /// int? target = 5;
  /// target.updateNonNullValue(target, 10);
  /// print(target); // Outputs: 10
  /// ```
  void updateNonNullValue<T>(T? target, T? value) {
    if (value != null) {
      target = value;
    }
  }

  /// A method to handle lists of non-null values.
  ///
  /// This method filters out any null values from a list, returning only the non-null items.
  /// It’s useful for working with lists where you want to ensure that only valid values are retained.
  ///
  /// **Example:**
  /// ```dart
  /// List<int?> values = [1, null, 3, null, 5];
  /// List<int> nonNullValues = values.updateListWithNonNull(values);
  /// print(nonNullValues); // Outputs: [1, 3, 5]
  /// ```
  List<M> updateListWithNonNull(List<M?> values) {
    return values.whereType<M>().toList();
  }
}
