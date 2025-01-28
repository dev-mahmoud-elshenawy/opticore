part of '../../util_import.dart';

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

/// A custom text input formatter that converts Arabic numerals to English numerals.
///
/// This formatter ensures that any Arabic numerals (`٠`, `١`, `٢`, etc.)
/// entered in a text field are automatically converted to their corresponding
/// English numerals (`0`, `1`, `2`, etc.). This is particularly useful for
/// applications that require consistent number formatting across different locales
/// or systems.
///
/// **Main Features:**
/// - Converts Arabic numerals in the input text to English numerals.
/// - Useful for applications that work with internationalized text inputs and require
///   consistent numerical representations.
///
/// ### Example Usage:
/// ```dart
/// TextField(
///   inputFormatters: [ArabicToEnglishNumberFormatter()],
/// );
/// ```
///
/// ### Conversion Table:
/// | AR | EN |
/// |--------|---------|
/// |   ٠    |    0    |
/// |   ١    |    1    |
/// |   ٢    |    2    |
/// |   ٣    |    3    |
/// |   ٤    |    4    |
/// |   ٥    |    5    |
/// |   ٦    |    6    |
/// |   ٧    |    7    |
/// |   ٨    |    8    |
/// |   ٩    |    9    |
class ArabicToEnglishNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    // Replace Arabic numerals with English numerals
    newText = newText
        .replaceAll('٠', '0')
        .replaceAll('١', '1')
        .replaceAll('٢', '2')
        .replaceAll('٣', '3')
        .replaceAll('٤', '4')
        .replaceAll('٥', '5')
        .replaceAll('٦', '6')
        .replaceAll('٧', '7')
        .replaceAll('٨', '8')
        .replaceAll('٩', '9');

    return newValue.copyWith(text: newText);
  }
}
