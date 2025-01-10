part of '../enum_import.dart';

/// Enum for different types of API responses.
///
/// This enum represents the various possible outcomes of an API call.
/// Each type indicates the nature of the response or error returned by the server,
/// allowing the app to handle different cases appropriately.
///
/// **Enum Values:**
/// - [SUCCESS]: The response was successful and contains the expected data.
/// - [NETWORK_ERROR]: There was a network error while making the request.
/// - [NO_INTERNET_ERROR]: The device does not have an internet connection.
/// - [SERVER_ERROR]: The response contained an error from the server (e.g., 5xx HTTP status codes).
/// - [UNAUTHORIZED_ERROR]: The response returned a 401 Unauthorized status.
/// - [API_ERROR]: The response returned a generic API error (e.g., invalid request).
/// - [PARSING_ERROR]: There was an error while parsing the response data.
/// - [NON]: There was no specific error type or the response doesn't fit any of the other categories.
enum ApiResponseType {
  /// The response was successful and contains the expected data.
  SUCCESS,

  /// There was a network error while making the request.
  NETWORK_ERROR,

  /// The device does not have an internet connection.
  NO_INTERNET_ERROR,

  /// The response contained an error from the server (e.g., 5xx HTTP status codes).
  SERVER_ERROR,

  /// The response returned a 401 Unauthorized status.
  UNAUTHORIZED_ERROR,

  /// The response returned a generic API error.
  API_ERROR,

  /// There was an error while parsing the response data.
  PARSING_ERROR,

  /// There was not a specific error type.
  NONE,
}