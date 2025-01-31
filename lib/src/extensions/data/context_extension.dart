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

  /// A getter that returns a boolean indicating whether the app is in dark mode.
  ///
  /// This can be useful for checking the current theme and applying custom UI adjustments
  /// based on whether the user is in dark mode or light mode.
  ///
  /// **Returns:**
  /// - `true` if the app is in dark mode, `false` otherwise.
  bool get isDarkMode =>
      MediaQuery.of(this).platformBrightness == Brightness.dark;

  /// A getter that returns the device's safe area insets, which are the parts of the screen
  /// that are not covered by system UI elements (like the notch, status bar, or navigation bar).
  ///
  /// **Returns:**
  /// - A [EdgeInsets] object representing the safe area insets.
  EdgeInsets get safeAreaInsets => MediaQuery.of(this).padding;

  /// A getter that returns the device's pixel density (devicePixelRatio) as retrieved from [MediaQuery].
  ///
  /// This can be helpful for creating responsive designs and handling different screen resolutions.
  ///
  /// **Returns:**
  /// - A double value representing the device's pixel density.
  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;

  /// A getter that returns a boolean indicating whether the device is in portrait mode.
  ///
  /// This can be useful for adapting the layout of your app depending on the device's orientation.
  ///
  /// **Returns:**
  /// - `true` if the device is in portrait mode, `false` otherwise.
  bool get isPortrait => deviceHeight > deviceWidth;

  /// A getter that returns a boolean indicating whether the device is in landscape mode.
  ///
  /// This can be useful for adapting the layout of your app depending on the device's orientation.
  ///
  /// **Returns:**
  /// - `true` if the device is in landscape mode, `false` otherwise.
  bool get isLandscape => deviceWidth > deviceHeight;

  /// A getter that returns the device's screen size as a [Size] object.
  ///
  /// This is a convenient way to retrieve both the screen height and width as a single object.
  ///
  /// **Returns:**
  /// - A [Size] object containing the device's screen width and height.
  Size get screenSize => MediaQuery.of(this).size;

  /// A getter that returns the device's text scale factor as retrieved from [MediaQuery].
  ///
  /// This property allows easy access to the text scale factor of the device,
  ///
  /// **Returns:**
  /// - A double value representing the text scale factor of the device.
  double get textScaleFactor => MediaQuery.textScalerOf(this).scale(1);
}
