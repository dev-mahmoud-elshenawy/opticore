part of '../extensions_import.dart';

/// Extension to add a `groupBy` method to `List<E>` for grouping elements.
///
/// This extension allows you to group elements of a list based on a key selected by
/// a provided function. It converts the list into a map where the keys are the values
/// derived from each element using the `keySelector` function, and the values are lists
/// of elements that share the same key.
///
/// **Example usage:**
/// ```dart
/// List<int> numbers = [1, 2, 2, 3, 3, 3];
/// Map<int, List<int>> grouped = numbers.groupBy((n) => n);
/// print(grouped); // Output: {1: [1], 2: [2, 2], 3: [3, 3, 3]}
/// ```
extension GroupByExtension<E> on List<E> {
  /// Groups the elements of the list by a key selected using the provided function.
  ///
  /// This method iterates over the elements of the list and groups them based on the
  /// key returned by the `keySelector` function. The result is a map where the keys
  /// represent the grouped criteria, and the values are lists of elements that share
  /// the same key.
  ///
  /// **Parameters:**
  /// - [keySelector]: A function that selects the key to group by from each element.
  ///
  /// **Returns:**
  /// - A map where the keys are the result of the `keySelector` function and the
  ///   values are lists of elements that correspond to each key.
  ///
  /// **Example usage:**
  /// ```dart
  /// List<String> words = ['apple', 'banana', 'apricot', 'blueberry'];
  /// Map<String, List<String>> groupedByFirstLetter = words.groupBy((word) => word[0]);
  /// print(groupedByFirstLetter); // Output: {'a': ['apple', 'apricot'], 'b': ['banana', 'blueberry']}
  /// ```
  Map<K, List<E>> groupBy<K>(K Function(E) keySelector) {
    final Map<K, List<E>> map = {};
    for (var element in this) {
      final key = keySelector(element);
      map.putIfAbsent(key, () => []).add(element);
    }
    return map;
  }
}