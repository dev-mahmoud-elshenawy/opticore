part of '../enum_import.dart';

/// Enum representing different types of toast messages.
///
/// This enum defines the various categories of toast messages that can be displayed to the user.
/// Each type corresponds to a different message style and significance, allowing the app
/// to communicate the outcome of actions or system statuses effectively.
///
/// **Enum Values:**
/// - [SUCCESS]: Represents a successful action or operation.
/// - [ERROR]: Represents an error or failure during an operation.
/// - [INFO]: Represents an informational message or status update.
/// - [WARNING]: Represents a warning or cautionary message.
enum ToastType {
  /// Represents a successful action or operation.
  SUCCESS,

  /// Represents an error or failure during an operation.
  ERROR,

  /// Represents an informational message or status update.
  INFO,

  /// Represents a warning or cautionary message.
  WARNING,
}