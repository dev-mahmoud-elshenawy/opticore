part of '../enum_import.dart';

/// An enumeration representing the standard HTTP methods.
///
/// This enum provides an easy way to work with HTTP methods in a type-safe
/// manner, avoiding string-based errors and improving code readability.
///
/// It simplifies interaction with HTTP methods by providing constant values
/// that can be used instead of raw strings, making the code more maintainable.
///
/// **Enum Values:**
/// - [get]: Represents the HTTP GET method, typically used for retrieving data.
/// - [post]: Represents the HTTP POST method, typically used for creating new resources.
/// - [put]: Represents the HTTP PUT method, typically used for updating or replacing resources.
/// - [patch]: Represents the HTTP PATCH method, typically used for partially updating resources.
/// - [delete]: Represents the HTTP DELETE method, typically used for deleting resources.
/// - [none]: Represents an unknown or unspecified HTTP method.
enum HTTPMethod {
  /// Represents the HTTP GET method, typically used for retrieving data.
  get,

  /// Represents the HTTP POST method, typically used for creating new resources.
  post,

  /// Represents the HTTP PUT method, typically used for updating or replacing resources.
  put,

  /// Represents the HTTP PATCH method, typically used for partially updating resources.
  patch,

  /// Represents the HTTP DELETE method, typically used for deleting resources.
  delete,

  /// Represents the HTTP HEAD method, typically used for downloading rescources.
  download,

  /// Represents an unknown or unspecified HTTP method.
  none;
}