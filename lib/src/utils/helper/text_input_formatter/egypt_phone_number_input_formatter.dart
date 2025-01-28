part of '../../util_import.dart';

/// A custom text input formatter that formats phone numbers for Egypt.
///
/// This formatter is designed specifically for Egyptian phone numbers, which have a country code of '20'.
/// It removes the leading '0' from the phone number if the country code is '20' and the number starts with '0'.
/// This ensures that the phone number is correctly formatted for use in Egypt.
///
/// **Main Features:**
/// - Removes the leading '0' from Egyptian phone numbers if the country code is '20'.
/// - Ensures that the phone number is correctly formatted for use in Egypt.
///
/// ### Example Usage:
/// ```dart
/// TextField(
///  inputFormatters: [EgyptPhoneNumberInputFormatter(countryPhoneCode: '20')],
///  keyboardType: TextInputType.phone,
///  decoration: InputDecoration(
///  hintText: 'Enter your phone number',
///  ),
///  );
///  ```
class EgyptPhoneNumberInputFormatter extends TextInputFormatter {
  final String countryPhoneCode;

  EgyptPhoneNumberInputFormatter({required this.countryPhoneCode});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove non-printing characters like LTR mark before performing any operations
    final cleanedText = newValue.text
        .replaceAll(RegExp(r'[\u200E\u200F\u200B\u200C\u200D\u200E]'), '');

    // If the country code is '20' (Egypt), and the number starts with '0', remove the leading '0'
    if (countryPhoneCode == '20' &&
        cleanedText.startsWith('0') &&
        cleanedText.length > 1) {
      final updatedText = cleanedText.substring(1);

      // Return the new text with the updated selection
      return newValue.copyWith(
        text: updatedText,
        selection: TextSelection.collapsed(offset: updatedText.length),
      );
    }

    // If no changes are needed, return the new value as is
    return newValue;
  }
}
