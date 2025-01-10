import 'package:flutter/material.dart';

/// A utility class that defines the color palette for the application.
///
/// This class provides a centralized location for managing colors used throughout the app.
class CoreColors {
  /// Private constructor to prevent instantiation.
  CoreColors._();

  /// Color used for success messages and states.
  static const Color success = Color(0xFF4CAF50);

  /// Color used for warning messages and states.
  static const Color warning = Color(0xFFE3B106);

  /// Color used for error messages and states.
  static const Color error = Color(0xFFC13515);

  /// Color used for informational messages and states.
  static const Color info = Color(0xFF004A9F);

  /// Background color for contrasting text and icons.
  static const Color backgroundColor = Color(0xFFFFFFFF);

  /// Color used for loading or secondary states.
  static const Color loading = Color(0xFF3F51B5);

  /// Color used for black.
  static const Color black = Color(0xFF000000);

  /// Color used for urgent actions or highlighting critical issues.
  static const Color red = Color(0xFFFF4747);

  /// Color used for transparent.
  static const Color hide = Color(0x00000000);
}
