part of '../../extensions_import.dart';

/// An extension on `Widget` to provide methods for aligning widgets
/// within their parent using the `Align` widget.
///
/// This extension simplifies the process of setting specific alignment
/// options for a widget.
extension AlignmentExtension on Widget {
  /// Aligns the widget to the top start corner of its parent.
  ///
  /// Example:
  /// ```dart
  /// Text("Top Start").alignTopStart;
  /// ```
  Widget get alignTopStart => Align(
        alignment: AlignmentDirectional.topStart,
        child: this,
      );

  /// Aligns the widget to the top end corner of its parent.
  ///
  /// Example:
  /// ```dart
  /// Text("Top End").alignTopEnd;
  /// ```
  Widget get alignTopEnd => Align(
        alignment: AlignmentDirectional.topEnd,
        child: this,
      );

  /// Aligns the widget to the bottom start corner of its parent.
  ///
  /// Example:
  /// ```dart
  /// Text("Bottom Start").alignBottomStart;
  /// ```
  Widget get alignBottomStart => Align(
        alignment: AlignmentDirectional.bottomStart,
        child: this,
      );

  /// Aligns the widget to the bottom end corner of its parent.
  ///
  /// Example:
  /// ```dart
  /// Text("Bottom End").alignBottomEnd;
  /// ```
  Widget get alignBottomEnd => Align(
        alignment: AlignmentDirectional.bottomEnd,
        child: this,
      );

  /// Aligns the widget to the center of its parent.
  ///
  /// Example:
  /// ```dart
  /// Text("Center").alignCenter;
  /// ```
  Widget get alignCenter => Align(
        alignment: Alignment.center,
        child: this,
      );

  /// Aligns the widget to the top center of its parent.
  ///
  /// Example:
  /// ```dart
  /// Text("Top Center").alignTopCenter;
  /// ```
  Widget get alignTopCenter => Align(
        alignment: Alignment.topCenter,
        child: this,
      );

  /// Aligns the widget to the bottom center of its parent.
  ///
  /// Example:
  /// ```dart
  /// Text("Bottom Center").alignBottomCenter;
  /// ```
  Widget get alignBottomCenter => Align(
        alignment: Alignment.bottomCenter,
        child: this,
      );
}

/// An extension on `Widget` to provide methods for centering widgets
/// within their parent using the `Center` widget.
///
/// This extension simplifies the process of centering a widget within its parent
/// without manually writing the `Center` widget each time.
extension CenterExtension on Widget {
  /// Wraps the widget with a [Center] widget.
  ///
  /// This is a convenient way to center a widget in its parent container
  /// without manually writing the `Center` widget each time.
  ///
  /// Example:
  /// ```dart
  /// Text("Hello, World!").center;
  /// ```
  Widget get center => Center(child: this);
}
