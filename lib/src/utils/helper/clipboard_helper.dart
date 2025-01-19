part of '../util_import.dart';

/// A utility class for managing clipboard operations in Flutter.
///
/// This class provides methods to copy and paste text or data to and from
/// the system clipboard, ensuring ease of integration into Flutter applications.
///
/// **Key Features:**
/// - **[copyText]**: Copy plain text to the system clipboard.
/// - **[pasteText]**: Retrieve plain text from the system clipboard.
/// - **[copyWithResult]**: Copy text to the clipboard and return a success indicator.
/// - **[getClipboardData]**: Retrieve clipboard data as a dynamic type.
///
class ClipboardHelper {
  /// Copies the given [text] to the system clipboard.
  ///
  /// If the provided [text] is empty, this method will throw an exception.
  ///
  /// Example:
  /// ```dart
  /// await ClipboardHelper.copyText('Hello, world!');
  /// ```
  ///
  /// Throws:
  /// - A [String] error message if the input text is empty.
  static Future<void> copyText(String text) async {
    if (text.isNotEmpty) {
      await Clipboard.setData(ClipboardData(text: text));
    } else {
      throw 'The provided text is empty. Please provide a valid string.';
    }
  }

  /// Retrieves plain text from the system clipboard.
  ///
  /// Returns the retrieved text as a [String], or an empty string if no text is
  /// available on the clipboard.
  ///
  /// Example:
  /// ```dart
  /// String clipboardText = await ClipboardHelper.pasteText();
  /// print(clipboardText);
  /// ```
  static Future<String> pasteText() async {
    final ClipboardData? data = await Clipboard.getData('text/plain');
    return data?.text ?? '';
  }

  /// Copies the given [text] to the system clipboard and returns a [bool] indicating success.
  ///
  /// Returns `true` if the operation is successful, or `false` if the provided
  /// [text] is empty.
  ///
  /// Example:
  /// ```dart
  /// bool isCopied = await ClipboardHelper.copyWithResult('Hello, Flutter!');
  /// if (isCopied) {
  ///   print('Text copied to clipboard!');
  /// }
  /// ```
  static Future<bool> copyWithResult(String text) async {
    if (text.isNotEmpty) {
      await Clipboard.setData(ClipboardData(text: text));
      return true;
    } else {
      return false;
    }
  }

  /// Retrieves data from the system clipboard as a dynamic type.
  ///
  /// This method is similar to [pasteText] but returns the raw [ClipboardData],
  /// which can include additional metadata if available.
  ///
  /// Example:
  /// ```dart
  /// var clipboardData = await ClipboardHelper.getClipboardData();
  /// print(clipboardData?.text);
  /// ```
  static Future<ClipboardData?> getClipboardData() async {
    return Clipboard.getData('text/plain');
  }
}
