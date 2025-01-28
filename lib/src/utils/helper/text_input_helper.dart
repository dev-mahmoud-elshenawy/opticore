part of '../util_import.dart';

/// A utility class to help manage text input formatting.
class TextInputHelper {
  /// Handles formatting for Egyptian phone numbers.
  ///
  /// This method listens for changes in the [controller]'s text and, if the country
  /// phone code is '20' (Egypt), removes the leading zero from the phone number
  /// if it starts with '0'. It also removes non-printing characters (e.g., LTR marks).
  ///
  /// The logic applied:
  /// - If the phone number starts with a '0' and has more than one character,
  ///   it will remove the leading '0'.
  /// - Non-printing characters like Left-To-Right marks (LTR) are also removed.
  ///
  /// Example usage:
  /// ```dart
  /// TextInputHelper.handleEgyptPhoneInput(
  ///   controller: _phoneController,
  ///   countryPhoneCode: selectedCountry?.phoneCode ?? '',
  /// );
  /// ```
  ///
  /// Parameters:
  /// - [controller]: The `TextEditingController` that controls the phone number field.
  /// - [countryPhoneCode]: The phone code of the country (e.g., '20' for Egypt).
  static void handleEgyptPhoneInput({
    TextEditingController? controller,
    String? countryPhoneCode,
  }) {
    if (controller == null || countryPhoneCode == null) return;

    controller.addListener(() {
      final String text = controller.text;

      // Remove non-printing characters like LTR mark before performing any operations
      final cleanedText =
          text.replaceAll(RegExp(r'[\u200E\u200F\u200B\u200C\u200D]'), '');

      // Proceed with the logic after cleaning the text
      if (countryPhoneCode == '20' &&
          cleanedText.startsWith('0') &&
          cleanedText.length > 1) {
        // Remove the leading zero if it's present
        controller.text = cleanedText.substring(1);

        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length),
        );
      }
    });
  }
}
