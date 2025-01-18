part of '../../extensions_import.dart';

/// An extension on `SizedBox` to provide concise methods for managing layout and spacing.
///
/// This extension simplifies the creation and configuration of `SizedBox` widgets,
/// offering methods for creating sized boxes with varying properties and behaviors.
extension SizedBoxExtension on Widget {
  /// Creates a [SizedBox] with a specified width.
  ///
  /// This is a shortcut to create a `SizedBox` with only width and no height.
  ///
  /// Example:
  /// ```dart
  /// Image.asset('test').width(100); // A box with 100 width and no height.
  /// ```
  ///
  /// [width]: The width of the `SizedBox`.
  Widget width(double width) {
    return SizedBox(width: width, child: this);
  }

  /// Creates a [SizedBox] with a specified height.
  ///
  /// This is a shortcut to create a `SizedBox` with only height and no width.
  ///
  /// Example:
  /// ```dart
  /// Image.asset('test').height(50); // A box with 50 height and no width.
  /// ```
  ///
  /// [height]: The height of the `SizedBox`.
  Widget height(double height) {
    return SizedBox(height: height, child: this);
  }

  /// Creates a [SizedBox] with both width and height.
  ///
  /// This is a shortcut to create a `SizedBox` with both width and height specified.
  ///
  /// Example:
  /// ```dart
  /// Image.asset('test').box(width: 100, height: 50); // A box with 100 width and 50 height.
  /// ```
  ///
  /// [width]: The width of the `SizedBox`.
  /// [height]: The height of the `SizedBox`.
  Widget box({required double width, required double height}) {
    return SizedBox(width: width, height: height, child: this);
  }

  /// Creates a [SizedBox] that fills the available space in both dimensions.
  ///
  /// This is equivalent to `SizedBox.expand()`, and ensures the box takes up all available space.
  ///
  /// Example:
  /// ```dart
  /// Image.asset('test').expand(); // A box that takes all available space.
  /// ```
  Widget expand() {
    return SizedBox.expand(child: this);
  }

  /// Creates a [SizedBox] with specified width, height, and alignment.
  ///
  /// This method is useful when you want to specify both size and alignment of the box.
  ///
  /// Example:
  /// ```dart
  /// Image.asset('test').alignedBox(width: 100, height: 50, alignment: Alignment.center); // A box with alignment in center.
  /// ```
  ///
  /// [width]: The width of the `SizedBox`.
  /// [height]: The height of the `SizedBox`.
  /// [alignment]: The alignment for the child widget within the `SizedBox`.
  Widget alignedBox({
    double? width,
    double? height,
    AlignmentDirectional? alignment,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: Align(
        alignment: alignment ?? AlignmentDirectional.topStart,
        child: this,
      ),
    );
  }

  /// Creates a [SizedBox] with padding around the child widget.
  ///
  /// This creates a `SizedBox` with the specified width and height and wraps its child with custom padding.
  ///
  /// Example:
  /// ```dart
  /// Image.asset('test').paddedBox(width: 100, height: 50, padding: EdgeInsets.all(8)); // A box with padding.
  /// ```
  ///
  /// [width]: The width of the `SizedBox`.
  /// [height]: The height of the `SizedBox`.
  /// [padding]: The padding to be applied around the child.
  Widget paddedBox({
    double? width,
    double? height,
    EdgeInsets? padding,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: this,
      ),
    );
  }

  /// Creates a [SizedBox] with a flexible width and height.
  ///
  /// This is useful when you want the box to be flexible in terms of its width or height.
  ///
  /// Example:
  /// ```dart
  /// Image.asset('test').flexible(width: 100); // A box with flexible height and fixed width.
  /// ```
  ///
  /// [width]: The fixed width of the `SizedBox`.
  /// [height]: The flexible height of the `SizedBox`.
  Widget flexible({required double width, double? height}) {
    return SizedBox(
      width: width,
      height: height ?? double.infinity,
      child: this,
    );
  }
}
