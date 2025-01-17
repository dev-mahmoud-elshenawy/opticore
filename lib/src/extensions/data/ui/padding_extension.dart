part of '../../extensions_import.dart';

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

/// An extension on `Widget` to simplify adding padding in a more fluent and readable way.
///
/// This extension provides methods for wrapping widgets with padding, allowing
/// for uniform, custom, or symmetric padding configurations.
extension PaddingExtension on Widget {
  /// Wraps the widget with a [Padding] widget using the specified [EdgeInsets].
  ///
  /// This method allows you to define custom padding for the widget.
  ///
  /// Example:
  /// ```dart
  /// Text("Hello").padding(EdgeInsets.all(8.0));
  /// ```
  ///
  /// [padding]: The [EdgeInsets] object defining the padding values.
  Widget paddingOnly({
    double top = 0,
    double bottom = 0,
    double start = 0,
    double end = 0,
  }) =>
      Padding(
        padding: EdgeInsetsDirectional.only(
          top: top,
          bottom: bottom,
          start: start,
          end: end,
        ),
        child: this,
      );

  /// Wraps the widget with a [Padding] widget applying uniform padding on all sides.
  ///
  /// This method simplifies adding the same padding value to all sides of the widget.
  ///
  /// Example:
  /// ```dart
  /// Text("Hello").paddingAll(16.0);
  /// ```
  ///
  /// [value]: The uniform padding value to apply on all sides.
  Widget paddingAll(double value) => Padding(
        padding: EdgeInsets.all(value),
        child: this,
      );

  /// Wraps the widget with a [Padding] widget applying symmetric padding.
  ///
  /// This method allows you to define separate padding for vertical and horizontal sides.
  ///
  /// Example:
  /// ```dart
  /// Text("Hello").paddingSymmetric(vertical: 10.0, horizontal: 20.0);
  /// ```
  ///
  /// [vertical]: The padding to apply vertically (top and bottom).
  /// [horizontal]: The padding to apply horizontally (left and right).
  Widget paddingSymmetric({
    double vertical = 0,
    double horizontal = 0,
  }) =>
      Padding(
        padding:
            EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
        child: this,
      );
}
