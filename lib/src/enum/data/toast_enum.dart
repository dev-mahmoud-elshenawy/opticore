part of '../enum_import.dart';

/// Enum representing different types of toast messages.
///
/// This enum defines the various categories of toast messages that can be displayed to the user.
/// Each type corresponds to a different message style and significance, allowing the app
/// to communicate the outcome of actions or system statuses effectively.
///
/// **Enum Values:**
/// - [success]: Represents a successful action or operation.
/// - [error]: Represents an error or failure during an operation.
/// - [info]: Represents an informational message or status update.
/// - [warning]: Represents a warning or cautionary message.
enum ToastType {
  /// Represents a successful action or operation.
  success,

  /// Represents an error or failure during an operation.
  error,

  /// Represents an informational message or status update.
  info,

  /// Represents a warning or cautionary message.
  warning,
}