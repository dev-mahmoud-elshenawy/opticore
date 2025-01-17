part of '../../extensions_import.dart';

/// A set of extension methods for `Widget` to simplify the usage of
/// `Expanded` and `Flexible` widgets in Flutter layouts.
///
/// These methods allow easy integration of the `Widget` inside a flex container
/// with customizable `flex` values and `fit` configurations.
extension FlexExtensions on Widget {
  /// Wraps the current widget with an `Expanded` widget, allowing it to expand
  /// and fill available space in a flex container (e.g., `Row`, `Column`).
  ///
  /// The `flex` factor determines the proportion of the available space
  /// this widget will take relative to other expanded widgets in the same
  /// flex container. Default value is `1`.
  ///
  /// Example usage:
  /// ```dart
  /// Row(
  ///   children: [
  ///     Text('Item 1'),
  ///     Text('Item 2').expanded(flex: 2), // Takes twice as much space as others
  ///   ],
  /// )
  /// ```
  ///
  /// [flex] The flex factor. Defaults to `1`.
  ///
  /// Returns a new `Expanded` widget containing the current widget.
  Widget expanded({
    int flex = 1,
  }) =>
      Expanded(
        flex: flex,
        child: this,
      );

  /// Wraps the current widget with a `Flexible` widget, allowing it to take
  /// flexible space within a flex container, but with more control over its
  /// layout behavior.
  ///
  /// The `flex` factor determines the space the widget takes relative to
  /// others. The `fit` parameter allows the widget to either fill the space
  /// loosely or tightly, depending on the `FlexFit` value.
  ///
  /// Example usage:
  /// ```dart
  /// Row(
  ///   children: [
  ///     Text('Item 1'),
  ///     Text('Item 2').flexible(flex: 2, fit: FlexFit.tight), // Takes twice as much space and fills it
  ///   ],
  /// )
  /// ```
  ///
  /// [flex] The flex factor. Defaults to `1`.
  /// [fit] Determines how the widget should fit in the available space. Defaults to `FlexFit.loose`.
  ///
  /// Returns a new `Flexible` widget containing the current widget.
  Widget flexible({
    int flex = 1,
    FlexFit fit = FlexFit.loose,
  }) =>
      Flexible(
        flex: flex,
        fit: fit,
        child: this,
      );
}
