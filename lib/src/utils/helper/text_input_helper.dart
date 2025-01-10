part of '../util_import.dart';

/// A custom text input formatter that capitalizes the first word of a text input.
///
/// This formatter ensures that the first letter of the text input is capitalized,
/// providing consistent and professional text formatting in forms and other input fields.
/// It only affects the first letter of the entire input while leaving the rest of the text as-is.
///
/// **Main Features:**
/// - Capitalizes the first letter of the text while maintaining the rest of the text as lowercase.
/// - Simple to integrate into any text field requiring this formatting behavior.
///
/// ### Example Usage:
/// ```dart
/// TextField(
///   inputFormatters: [CapitalizeFirstWordFormatter()],
/// );
/// ```
class CapitalizeFirstWordFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;

    // Capitalize only the first letter of the entire input
    String modifiedText = newValue.text[0].toUpperCase() +
        newValue.text.substring(
          1,
        );

    return newValue.copyWith(
      text: modifiedText,
      selection: newValue.selection,
    );
  }
}
