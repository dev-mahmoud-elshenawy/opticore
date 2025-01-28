part of '../../util_import.dart';

/// A custom text input formatter that forces the text direction to be left-to-right (LTR).
///
/// This formatter ensures that the text direction of the input text is always left-to-right (LTR),
/// regardless of the system locale or the text content. It is useful for applications that require
/// consistent text directionality for input fields, such as usernames, passwords, or other text inputs.
///
/// **Main Features:**
/// - Forces the text direction to be left-to-right (LTR) for the input text.
/// - Useful for applications that require consistent text directionality for text fields.
///
/// ### Example Usage:
/// ```dart
/// TextField(
///  inputFormatters: [ForceLTRInputFormatter()],
///  textAlign: TextAlign.start,
///  textDirection: TextDirection.ltr,
///  decoration: InputDecoration(
///  hintText: 'Enter your username',
///  ),
///  );
///  ```
class ForceLTRInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Apply forceLTR transformation
    final newText = newValue.text.forceLTR;

    // Return a new TextEditingValue with the modified text and the updated selection
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
