part of '../../extensions_import.dart';

/// An extension on [Widget] to provide convenient methods for creating positioned widgets.
///
/// This extension simplifies the creation of [Positioned], [Positioned.fill],
/// and [PositionedDirectional] widgets by adding utility methods to any widget.
///
/// ### Features:
/// - Easily position a widget with `positioned`, `positionedFill`, or `positionedDirectional`.
/// - Avoid repetitive wrapping by calling these methods directly on widgets.
///
/// ### Example Usage:
/// ```dart
/// Text('Hello, World!')
///   .positioned(top: 10, end: 20)
///
/// Container(color: Colors.red)
///   .positionedFill(top: 0, bottom: 0)
///
/// Icon(Icons.star)
///   .positionedDirectional(
///     textDirection: TextDirection.ltr,
///     start: 10,
///     end: 10,
///   )
/// ```

extension PositionedExtension on Widget {
  /// Wraps the widget with a [PositionedDirectional] widget.
  ///
  /// Allows you to specify top, bottom, left, right, width, and height
  /// for positioning the widget inside a [Stack] with text direction support.
  ///
  /// ### Parameters:
  /// - [top]: Distance from the top edge.
  /// - [bottom]: Distance from the bottom edge.
  /// - [left]: Distance from the start edge (affected by text direction).
  /// - [right]: Distance from the end edge (affected by text direction).
  /// - [width]: The width of the widget.
  /// - [height]: The height of the widget.
  ///
  /// ### Example:
  /// ```dart
  /// Text('Positioned Text')
  ///   .positioned(top: 10, end: 20, width: 100, height: 50)
  /// ```
  Widget positioned({
    double? top,
    double? bottom,
    double? start,
    double? end,
    double? width,
    double? height,
  }) =>
      PositionedDirectional(
        top: top,
        bottom: bottom,
        start: start,
        end: end,
        width: width,
        height: height,
        child: this,
      );

  /// Wraps the widget with a [Positioned.fill] widget.
  ///
  /// This is useful for creating widgets that fill the available space
  /// within a [Stack], with optional margins from the edges.
  ///
  /// ### Parameters:
  /// - [top]: Distance from the top edge.
  /// - [bottom]: Distance from the bottom edge.
  /// - [left]: Distance from the left edge.
  /// - [right]: Distance from the right edge.
  ///
  /// ### Example:
  /// ```dart
  /// Container(color: Colors.blue)
  ///   .positionedFill(top: 5, bottom: 5)
  /// ```
  Widget positionedFill({
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) =>
      Positioned.fill(
        top: top,
        bottom: bottom,
        left: left,
        right: right,
        child: this,
      );

  /// Wraps the widget with a [Positioned.directional] widget.
  ///
  /// This method provides more flexibility by taking into account the
  /// [TextDirection], which determines whether the `start` and `end` parameters
  /// correspond to the left-to-right or right-to-left directions.
  ///
  /// ### Parameters:
  /// - [textDirection]: Specifies the text direction (LTR or RTL).
  /// - [top]: Distance from the top edge.
  /// - [bottom]: Distance from the bottom edge.
  /// - [start]: Distance from the start edge (affected by text direction).
  /// - [end]: Distance from the end edge (affected by text direction).
  /// - [width]: The width of the widget.
  /// - [height]: The height of the widget.
  ///
  /// ### Example:
  /// ```dart
  /// Icon(Icons.arrow_back)
  ///   .positionedDirectional(
  ///     textDirection: TextDirection.rtl,
  ///     start: 10,
  ///     end: 20,
  ///     top: 15,
  ///   )
  /// ```
  Widget positionedDirectional({
    required TextDirection textDirection,
    double? top,
    double? bottom,
    double? start,
    double? end,
    double? width,
    double? height,
  }) =>
      Positioned.directional(
        textDirection: textDirection,
        top: top,
        bottom: bottom,
        start: start,
        end: end,
        width: width,
        height: height,
        child: this,
      );
}
