part of '../enum_import.dart';

/// Enum for different types of API responses.
///
/// This enum represents the various possible outcomes of an API call.
/// Each type indicates the nature of the response or error returned by the server,
/// allowing the app to handle different cases appropriately.
///
/// **Enum Values:**
/// - [success]: The response was successful and contains the expected data.
/// - [networkError]: There was a network error while making the request.
/// - [noInternetError]: The device does not have an internet connection.
/// - [serverError]: The response contained an error from the server (e.g., 5xx HTTP status codes).
/// - [unauthorizedError]: The response returned a 401 Unauthorized status.
/// - [apiError]: The response returned a generic API error (e.g., invalid request).
/// - [parsingError]: There was an error while parsing the response data.
/// - [none]: There was no specific error type or the response doesn't fit any of the other categories.
enum ApiResponseType {
  /// The response was successful and contains the expected data.
  success,

  /// There was a network error while making the request.
  networkError,

  /// The device does not have an internet connection.
  noInternetError,

  /// The response contained an error from the server (e.g., 5xx HTTP status codes).
  serverError,

  /// The response returned a 401 Unauthorized status.
  unauthorizedError,

  /// The response returned a generic API error.
  apiError,

  /// There was an error while parsing the response data.
  parsingError,

  /// There was not a specific error type.
  none,
}