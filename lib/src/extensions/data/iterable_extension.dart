part of '../extensions_import.dart';

/// A collection of extension methods for [Iterable] to enhance its functionality.
///
/// These methods provide additional capabilities such as finding the first element that matches a condition,
/// checking if the collection is empty, and more.
///
/// This extension is designed to be used with any iterable collection in Dart,
/// including lists, sets, and maps.
extension IterableExtension<M> on Iterable<M> {
  /// Returns the first element that satisfies the provided [execute] condition.
  ///
  /// If no element satisfies the condition, it returns `null`.
  ///
  /// Example:
  /// ```dart
  /// final numbers = [1, 2, 3, 4, 5];
  /// final firstEven = numbers.firstWhereOrNull((n) => n.isEven);
  /// print(firstEven); // Output: 2
  /// final firstGreaterThanFive = numbers.firstWhereOrNull((n) => n > 5);
  /// print(firstGreaterThanFive); // Output: null
  /// ```
  M? firstWhereOrNull(bool Function(M) execute) {
    for (final element in this) {
      if (execute(element)) return element;
    }
    return null;
  }
}
