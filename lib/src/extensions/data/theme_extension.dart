part of '../extensions_import.dart';

/// Extension for adding convenience methods to [BuildContext] to access theme properties.
///
/// This extension provides helper properties for retrieving theme-related information
/// directly from the [BuildContext], reducing the need for repetitive calls to
/// `Theme.of(context)` in your Flutter code.
///
/// **Example usage:**
/// ```dart
/// Text(
///   'Hello Mahmoud!',
///   style: context.textTheme.headlineSmall,
/// );
/// Container(
///   color: context.primaryColor,
/// );
/// ```
extension ThemeExtension on BuildContext {
  /// Returns the current [ThemeData] for the app.
  ///
  /// Use this property to access general theme properties, such as colors,
  /// typography, and component themes.
  ThemeData get theme => Theme.of(this);

  /// Returns the current [TextTheme] for the app.
  ///
  /// Use this property to style text widgets with predefined styles.
  TextTheme get textTheme => theme.textTheme;

  /// Returns the primary [TextTheme] for the app.
  ///
  /// This is typically used when the app uses a custom primary theme for texts.
  TextTheme get primaryTextTheme => theme.primaryTextTheme;

  /// Returns the current [ColorScheme] for the app.
  ///
  /// This property provides access to the app's primary, secondary, background,
  /// and other key colors defined in the theme.
  ColorScheme get colorScheme => theme.colorScheme;

  /// Returns the primary color of the current theme.
  ///
  /// Useful for widgets that need to match the app's primary branding color.
  Color get primaryColor => theme.primaryColor;

  /// Returns the primary color of the current theme.
  ///
  /// Useful for widgets that need to match the app's primary branding color.
  Color get secondaryColor => theme.colorScheme.secondary;

  /// Returns the secondary header color of the current theme.
  ///
  /// This color is often used for smaller or less prominent UI elements.
  Color get secondaryHeaderColor => theme.secondaryHeaderColor;

  /// Returns the scaffold background color of the current theme.
  ///
  /// Typically used as the background color for pages.
  Color get scaffoldBackgroundColor => theme.scaffoldBackgroundColor;

  /// Returns the card color of the current theme.
  ///
  /// Use this color to style cards and surfaces in your app.
  Color get cardColor => theme.cardColor;

  /// Returns the divider color of the current theme.
  ///
  /// Use this color for separators between sections or items.
  Color get dividerColor => theme.dividerColor;

  /// Returns the disabled color of the current theme.
  ///
  /// This is commonly used for disabled buttons or text.
  Color get disabledColor => theme.disabledColor;

  /// Returns the error color defined in the current theme's [ColorScheme].
  ///
  /// Useful for highlighting errors or warnings in the UI.
  Color get errorColor => theme.colorScheme.error;

  /// Returns the typography settings of the current theme.
  ///
  /// Use this property to access additional typography configurations.
  Typography get typography => theme.typography;

  /// Returns the default icon theme of the current theme.
  ///
  /// Use this property to style icons consistently across your app.
  IconThemeData get iconTheme => theme.iconTheme;

  /// Returns the primary icon theme of the current theme.
  ///
  /// Useful for styling icons in app bars and other primary UI components.
  IconThemeData get primaryIconTheme => theme.primaryIconTheme;

  /// Returns the button theme of the current theme.
  ///
  /// This property provides styles for legacy buttons like `RaisedButton`.
  ButtonThemeData get buttonTheme => theme.buttonTheme;

  /// Returns the app bar theme of the current theme.
  ///
  /// Use this property to style app bars consistently across the app.
  AppBarThemeData get appBarTheme => theme.appBarTheme;

  /// Returns the input decoration theme of the current theme.
  ///
  /// Use this property to style input fields consistently.
  InputDecorationThemeData get inputDecorationTheme => theme.inputDecorationTheme;

  /// Returns the bottom navigation bar theme of the current theme.
  ///
  /// Use this property to style the bottom navigation bar in your app.
  BottomNavigationBarThemeData get bottomNavigationBarTheme =>
      theme.bottomNavigationBarTheme;

  /// Returns the elevated button theme of the current theme.
  ///
  /// This property provides styles for `ElevatedButton` widgets.
  ElevatedButtonThemeData get elevatedButtonTheme => theme.elevatedButtonTheme;

  /// Returns the outlined button theme of the current theme.
  ///
  /// This property provides styles for `OutlinedButton` widgets.
  OutlinedButtonThemeData get outlinedButtonTheme => theme.outlinedButtonTheme;

  /// Returns the text button theme of the current theme.
  ///
  /// This property provides styles for `TextButton` widgets.
  TextButtonThemeData get textButtonTheme => theme.textButtonTheme;

  /// Returns the chip theme of the current theme.
  ///
  /// Use this property to style chips consistently across the app.
  ChipThemeData get chipTheme => theme.chipTheme;

  /// Returns the tab bar theme of the current theme.
  ///
  /// Use this property to style tab bars consistently across the app.
  TabBarThemeData get tabBarTheme => theme.tabBarTheme;

  /// Returns the checkbox theme of the current theme.
  ///
  /// Use this property to style checkboxes consistently across the app.
  CheckboxThemeData get checkboxTheme => theme.checkboxTheme;

  /// Returns the radio theme of the current theme.
  ///
  /// Use this property to style radio buttons consistently across the app.
  RadioThemeData get radioTheme => theme.radioTheme;

  /// Returns the switch theme of the current theme.
  ///
  /// Use this property to style switches consistently across the app.
  SwitchThemeData get switchTheme => theme.switchTheme;

  /// Returns the slider theme of the current theme.
  ///
  /// Use this property to style sliders consistently across the app.
  SliderThemeData get sliderTheme => theme.sliderTheme;

  /// Returns the progress indicator theme of the current theme.
  ///
  /// Use this property to style progress indicators consistently across the app.
  ProgressIndicatorThemeData get progressIndicatorTheme =>
      theme.progressIndicatorTheme;

  /// Returns the dialog theme of the current theme.
  ///
  /// Use this property to style dialogs consistently across the app.
  DialogThemeData get dialogTheme => theme.dialogTheme;

  /// Returns the tooltip theme of the current theme.
  ///
  /// Use this property to style tooltips consistently across the app.
  TooltipThemeData get tooltipTheme => theme.tooltipTheme;

  /// Returns the visual density of the current theme.
  ///
  /// This property controls the spacing between UI elements.
  VisualDensity get visualDensity => theme.visualDensity;

  /// Returns the hover color of the current theme.
  ///
  /// Use this property to style elements that respond to hover interactions.
  Color get hoverColor => theme.hoverColor;

  /// Returns the highlight color of the current theme.
  ///
  /// Use this property to style elements that are highlighted.
  Color get highlightColor => theme.highlightColor;

  /// Returns the focus color of the current theme.
  ///
  /// Use this property to style elements that have focus.
  Color get focusColor => theme.focusColor;

  /// Returns the splash color of the current theme.
  ///
  /// Use this property to style elements with splash effects.
  Color get splashColor => theme.splashColor;

  /// Returns the material tap target size of the current theme.
  ///
  /// This property affects the touch target size of widgets.
  MaterialTapTargetSize get materialTapTargetSize =>
      theme.materialTapTargetSize;

  /// Toggles between light and dark theme if a stateful theme manager is used.
  ///
  /// **Example Usage:**
  /// ```dart
  /// context.toggleTheme();
  /// ```
  void toggleTheme() {
    final brightness = isDarkMode ? Brightness.light : Brightness.dark;
    theme.copyWith(brightness: brightness);
  }
}
