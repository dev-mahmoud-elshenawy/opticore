part of '../import/base_import.dart';

/// Defines the types of errors that can occur within the application.
///
/// This class contains static constants that represent different categories
/// of errors, allowing developers to classify and handle errors more effectively
/// throughout the application. The class serves as a container for these
/// predefined error types, ensuring that error handling is consistent and
/// easily maintainable across the system.
///
/// ### Usage
/// Use the constants defined in `ErrorType` to classify errors based on their
/// nature, such as rendering issues or other state-related errors:
///
/// ```dart
/// String errorType = ErrorType.RENDER;
/// ```
///
/// This class can be particularly useful when managing different types of
/// error states or when logging error information for debugging purposes.
///
/// ### Example Workflow
/// 1. Identify the type of error that occurred (e.g., rendering error,
///    state-related error).
/// 2. Use the appropriate constant from `ErrorType` to classify the error.
/// 3. Handle the error according to its type (e.g., display an error message,
///    retry the operation, or log it for further analysis).
///
/// ### Key Benefits
/// - Provides a centralized way to define and manage error types.
/// - Helps improve error classification and handling across the application.
/// - Ensures consistency in how errors are referenced and handled.
class ErrorType {
  /// Represents an error type related to rendering issues, such as UI or
  /// graphics rendering failures.
  ///
  /// Example usage:
  /// ```dart
  /// if (errorType == ErrorType.RENDER) {
  ///   // Handle rendering-related error.
  /// }
  /// ```
  static const String RENDER = 'RENDER';

  /// Represents an error type that is not related to rendering but still
  /// impacts the application state, such as business logic or data issues.
  ///
  /// Example usage:
  /// ```dart
  /// if (errorType == ErrorType.NON_RENDER) {
  ///   // Handle non-rendering related error.
  /// }
  /// ```
  static const String NON_RENDER = 'NON_RENDER';

  /// Represents a general or undefined error type, used when the error type
  /// cannot be categorized or is unknown.
  ///
  /// Example usage:
  /// ```dart
  /// if (errorType == ErrorType.NONE) {
  ///   // Handle general error.
  /// }
  /// ```
  static const String NONE = 'NONE';

  /// Prevents instantiation of this class as it only serves as a container
  /// for error type constants.
  ///
  /// Since this class contains only static constants, there is no need for
  /// creating an instance of it. This constructor ensures that no instances
  /// can be created.
  const ErrorType._();
}