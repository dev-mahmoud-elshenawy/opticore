part of '../../extensions_import.dart';

/// An extension on `Widget` to provide concise methods for managing visibility.
///
/// This extension simplifies toggling widget visibility and conditionally hiding widgets
/// based on specific conditions.
extension VisibilityExtension on Widget {
  /// Wraps the widget with a [Visibility] widget to conditionally show or hide it.
  ///
  /// The widget remains in the widget tree but is not rendered when [isVisible] is `false`.
  /// It also occupies its original space.
  ///
  /// Example:
  /// ```dart
  /// Text("Hello").visible(true); // Widget is visible.
  /// Text("Hello").visible(false); // Widget is hidden but occupies space.
  /// ```
  ///
  /// [isVisible]: Determines whether the widget should be visible or hidden.
  Widget visible(bool isVisible) => Visibility(
        visible: isVisible,
        child: this,
      );

  /// Conditionally hides the widget by replacing it with an empty widget ([SizedBox.shrink]).
  ///
  /// When [isHidden] is `true`, the widget is replaced with an empty widget
  /// that does not occupy space. When [isHidden] is `false`, the widget is displayed.
  ///
  /// Example:
  /// ```dart
  /// Text("Hello").hide(true); // Widget is replaced with an empty widget.
  /// Text("Hello").hide(false); // Widget is displayed.
  /// ```
  ///
  /// [isHidden]: Determines whether the widget should be hidden.
  Widget hide(bool isHidden) => isHidden ? const SizedBox.shrink() : this;

  /// Wraps the widget with an [AnimatedOpacity] widget to animate its visibility.
  ///
  /// The widget fades in or out based on the [isVisible] parameter. You can customize the
  /// animation duration using the [duration] parameter.
  ///
  /// Example:
  /// ```dart
  /// Text("Hello").animatedOpacity(true); // Widget fades in.
  /// Text("Hello").animatedOpacity(false); // Widget fades out.
  /// ```
  AnimatedOpacity animatedOpacity(
    bool isVisible, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return AnimatedOpacity(
      duration: duration,
      opacity: isVisible ? 1.0 : 0.0,
      child: this,
    );
  }
}
