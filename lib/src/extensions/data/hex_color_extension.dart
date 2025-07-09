part of '../extensions_import.dart';

/// Extension to convert a hex color code string to a [Color] object.
///
/// This extension adds a `toColor` method to the `String` class to easily convert
/// a hex color code in the form of a string (e.g., "#FF5733" or "FF5733") into
/// a [Color] object. It provides error handling in case the provided string
/// does not represent a valid hex color code.
///
/// **Example usage:**
/// ```dart
/// String hexColor = "#FF5733";
/// Color color = hexColor.toColor();
/// print(color); // Output: Color(0xffff5733)
/// ```
extension HexColorExtension on String {
  /// Converts a hex color code string to a [Color] object.
  ///
  /// This method checks if the string starts with a '#' character and removes
  /// it if necessary. Then, it attempts to parse the hex code and return
  /// the corresponding [Color] object. If the parsing fails (invalid hex code),
  /// it logs an error and returns the default color black.
  ///
  /// **Returns:**
  /// - A [Color] object corresponding to the hex color code.
  /// - If the hex code is invalid, it returns [Colors.black] and logs an error.
  ///
  /// **Example usage:**
  /// ```dart
  /// String hexColor = "FF5733";
  /// Color color = hexColor.toColor();
  /// print(color); // Output: Color(0xffff5733)
  /// ```
  Color get toColor {
    String hex = replaceFirst('#', '').trim();

    // Expand 3-digit shorthand
    if (hex.length == 3) {
      hex = hex.split('').map((c) => c * 2).join();
    }

    // Prepend opaque alpha if only RGB supplied
    if (hex.length == 6) hex = 'FF$hex';

    // Expect 8-digit ARGB at this point
    if (hex.length != 8) {
      Logger.error('Invalid hex color code: $this');
      return Colors.black;
    }

    try {
      return Color(int.parse(hex, radix: 16));
    } catch (_) {
      Logger.error('Invalid hex color code: $this');
      return Colors.black;
    }
  }

  /// Converts a hex color code string to a [Color] object with an alpha channel.
  ///
  /// This method is similar to [toColor], but it supports ARGB hex color codes
  /// (8 characters) by parsing the alpha channel as well. If the hex code is
  /// not in ARGB format, it falls back to RGB format.
  ///
  /// **Returns:**
  /// - A [Color] object corresponding to the hex color code.
  /// - If the hex code is invalid, it returns [Colors.black] and logs an error.
  ///
  /// **Example usage:**
  /// ```dart
  /// String hexColor = "FF5733";
  /// Color color = hexColor.toColorWithAlpha;
  /// print(color); // Output: Color(0xffff5733)
  /// ```
  Color get toColorWithAlpha {
    String hexString = startsWith('#') ? substring(1) : this;

    // If the hex code is 8 characters, it’s ARGB (Alpha, Red, Green, Blue)
    if (hexString.length == 8) {
      try {
        return Color(int.parse(hexString, radix: 16));
      } catch (e) {
        Logger.error('Invalid ARGB hex color code: $this');
        return Colors.black;
      }
    } else {
      // If not ARGB, fallback to RGB
      return toColor;
    }
  }
}
