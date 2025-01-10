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
/// - [GET]: Represents the HTTP GET method, typically used for retrieving data.
/// - [POST]: Represents the HTTP POST method, typically used for creating new resources.
/// - [PUT]: Represents the HTTP PUT method, typically used for updating or replacing resources.
/// - [PATCH]: Represents the HTTP PATCH method, typically used for partially updating resources.
/// - [DELETE]: Represents the HTTP DELETE method, typically used for deleting resources.
/// - [NONE]: Represents an unknown or unspecified HTTP method.
enum HTTPMethod {
  /// Represents the HTTP GET method, typically used for retrieving data.
  GET,

  /// Represents the HTTP POST method, typically used for creating new resources.
  POST,

  /// Represents the HTTP PUT method, typically used for updating or replacing resources.
  PUT,

  /// Represents the HTTP PATCH method, typically used for partially updating resources.
  PATCH,

  /// Represents the HTTP DELETE method, typically used for deleting resources.
  DELETE,

  /// Represents an unknown or unspecified HTTP method.
  NONE;
}