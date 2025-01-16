part of '../import/base_import.dart';

/// Mixin to handle various UI state changes.
///
/// This mixin provides methods to manage common UI states such as showing
/// or hiding a loading indicator, displaying success, warning, info, or error
/// messages, and closing the keyboard. It is intended to be used by classes
/// that need to handle UI state transitions, typically within a ViewModel or
/// UI-related logic.
///
/// By using this mixin, you can easily implement consistent UI state management
/// across different parts of your app, reducing the need to write repetitive code.
///
/// ### Usage
/// To use this mixin, simply apply it to a class that manages UI state:
///
/// ```dart
/// class MyViewModel with ViewStateHandler {
///   @override
///   void showLoading() {
///     // Implement show loading logic
///   }
///   @override
///   void hideLoading() {
///     // Implement hide loading logic
///   }
///   // Implement other methods as needed
/// }
/// ```
///
/// ### Example Workflow
/// 1. Add `ViewStateHandler` to a class.
/// 2. Implement the required methods to manage UI state changes.
///
/// This mixin is especially useful in scenarios where you need to provide
/// feedback to users about ongoing processes or potential issues, like
/// showing loading indicators, success messages, or handling error states.
mixin ViewStateHandler {
  /// Shows a loading indicator.
  ///
  /// This method should be implemented to display a loading spinner or any
  /// other UI element indicating that an operation is in progress.
  ///
  /// ### Example
  /// ```dart
  /// showLoading();
  /// ```
  void showLoading();

  /// Hides the loading indicator.
  ///
  /// This method should be implemented to hide the loading spinner or any
  /// other UI element once the operation is complete.
  ///
  /// ### Example
  /// ```dart
  /// hideLoading();
  /// ```
  void hideLoading();

  /// Displays a success message.
  ///
  /// Optionally, a [message] can be provided to describe the success. If no
  /// message is provided, a default success message can be shown.
  ///
  /// ### Example
  /// ```dart
  /// showSuccess(message: 'Operation completed successfully!');
  /// ```
  void showSuccess({String? message});

  /// Displays a warning message.
  ///
  /// Optionally, a [message] can be provided to describe the warning. If no
  /// message is provided, a default warning message can be shown.
  ///
  /// ### Example
  /// ```dart
  /// showWarning(message: 'This is a warning.');
  /// ```
  void showWarning({String? message});

  /// Displays an informational message.
  ///
  /// Optionally, a [message] can be provided to describe the information.
  /// If no message is provided, a default informational message can be shown.
  ///
  /// ### Example
  /// ```dart
  /// showInfo(message: 'Here is some information.');
  /// ```
  void showInfo({String? message});

  /// Displays an error message.
  ///
  /// Optionally, a [message] can be provided to describe the error. If no
  /// message is provided, a default error message can be shown.
  ///
  /// ### Example
  /// ```dart
  /// showError(message: 'An error occurred.');
  /// ```
  void showError({String? message});

  /// Closes the keyboard.
  ///
  /// This method should be implemented to dismiss the soft keyboard, typically
  /// after the user has completed their input or when the keyboard is no longer
  /// needed.
  ///
  /// ### Example
  /// ```dart
  /// closeKeyboard();
  /// ```
  void closeKeyboard();
}
