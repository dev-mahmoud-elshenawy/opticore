part of '../extensions_import.dart';

/// Extension for adding convenience methods to [BuildContext].
///
/// This extension adds helper properties to the [BuildContext] to easily access
/// device-specific information and theme data. This helps in reducing boilerplate code
/// when dealing with `MediaQuery` and `Theme` in the UI code.
///
/// **Example usage:**
/// ```dart
/// double height = context.deviceHeight;
/// double width = context.deviceWidth;
/// ThemeData theme = context.theme;
/// ```
extension BuildContextExtension on BuildContext {
  /// A getter that returns the device's screen height, as retrieved from [MediaQuery].
  ///
  /// This property allows easy access to the height of the device screen,
  /// which can be useful for responsive design and layout adjustments.
  ///
  /// **Returns:**
  /// - A double value representing the height of the device's screen.
  double get deviceHeight => MediaQuery.of(this).size.height;

  /// A getter that returns the device's screen width, as retrieved from [MediaQuery].
  ///
  /// This property allows easy access to the width of the device screen,
  /// which can be useful for responsive design and layout adjustments.
  ///
  /// **Returns:**
  /// - A double value representing the width of the device's screen.
  double get deviceWidth => MediaQuery.of(this).size.width;

  /// A getter that returns the current theme data for the app, as retrieved from [Theme].
  ///
  /// This property allows easy access to the theme's colors, text styles,
  /// and other theme-related data without needing to reference `Theme.of(context)` repeatedly.
  ///
  /// **Returns:**
  /// - A [ThemeData] object containing the app's current theme information.
  ThemeData get theme => Theme.of(this);
}
