part of '../extensions_import.dart';

/// Extension on [num] to provide shorthand for horizontal and vertical padding.
///
/// This extension adds helper methods to the `num` type to quickly create `SizedBox` widgets
/// that serve as empty padding. The `ph` and `pw` getters simplify adding padding along
/// the height and width axis respectively by converting a numeric value into a `SizedBox`.
///
/// **Example usage:**
/// ```dart
/// 10.ph  // Creates a vertical padding of 10 units
/// 20.pw  // Creates a horizontal padding of 20 units
/// ```
extension EmptyPadding on num {
  /// Creates vertical padding (`SizedBox`) based on the number value.
  ///
  /// This getter returns a `SizedBox` with a height equal to the number's value. The value
  /// is automatically converted to a `double` to accommodate `SizedBox`'s `height` parameter.
  ///
  /// **Example:**
  /// ```dart
  /// 10.ph  // Equivalent to SizedBox(height: 10)
  /// ```
  SizedBox get ph => SizedBox(height: toDouble());

  /// Creates horizontal padding (`SizedBox`) based on the number value.
  ///
  /// This getter returns a `SizedBox` with a width equal to the number's value. The value
  /// is automatically converted to a `double` to accommodate `SizedBox`'s `width` parameter.
  ///
  /// **Example:**
  /// ```dart
  /// 20.pw  // Equivalent to SizedBox(width: 20)
  /// ```
  SizedBox get pw => SizedBox(width: toDouble());
}