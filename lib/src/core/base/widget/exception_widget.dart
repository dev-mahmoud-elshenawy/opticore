import 'package:flutter/material.dart';
import 'package:opticore/src/utils/ui/core_colors.dart';

/// A widget that displays an error message in the center of the screen.
///
/// The [ExceptionWidget] is designed to show a user-friendly error message when
/// an exception occurs. It uses a bold and error-colored text style to highlight
/// the message, ensuring the error is prominent for the user.
///
/// This widget is particularly useful for scenarios where an exception is caught
/// and needs to be communicated to the user, such as during failed network requests
/// or when an unexpected error occurs in the app.
///
/// ### Constructor Parameters:
/// - [message]: An optional error message to display. If no message is provided,
///   an empty string will be shown.
///
/// ### Example Usage:
/// ```dart
/// ExceptionWidget(message: 'Something went wrong! Please try again.');
/// ```
///
/// If no message is passed:
/// ```dart
/// ExceptionWidget();
/// ```
class ExceptionWidget extends StatelessWidget {
  /// The error message to display.
  ///
  /// If no message is provided, an empty string is displayed by default.
  final String? message;

  /// Creates an [ExceptionWidget] instance.
  ///
  /// - [message]: The optional error message to display. If omitted, an empty
  ///   string will be shown.
  const ExceptionWidget({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message ?? '', // Displays an empty string if no message is provided
        style: const TextStyle(
          fontWeight: FontWeight.bold, // Makes the text bold
          color: CoreColors.error, // Uses the error color from CoreColors
        ),
        textAlign: TextAlign.center, // Centers the text within the widget
      ),
    );
  }
}
