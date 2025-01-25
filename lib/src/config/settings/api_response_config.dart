part of '../config_import.dart';

/// A class to configure the messages displayed for different API response scenarios.
///
/// This class allows you to set custom messages for the following scenarios:
/// - Request timeout
/// - Network issues
/// - Generic error
///
/// You can set custom messages globally using the `instantiate` method or reset
/// the configuration to default values using the `resetToDefaults` method.
///
/// **Note:** The custom messages provided will be used across the app for API response scenarios.
///
/// **Example:**
/// ```dart
/// ApiResponseConfig.instantiate(
///  ApiResponseConfig(
///  customRequestTimeoutMessage: 'Request took too long.',
///  customNetworkIssuesMessage: 'No internet detected.',
///  ),
///  );
///  ```
class ApiResponseConfig extends Equatable {
  // Private static fields to store the global default configuration values
  /// The default message displayed for a request timeout.
  static String _requestTimeoutMessage =
      'The request timed out. Please try again later.';

  /// The default message displayed for network issues.
  static String _networkIssuesMessage =
      'Network issues detected. Please check your connection.';

  /// The default message displayed for a generic error.
  static String _errorMessage = 'An error occurred. Please try again later.';

  // Instance fields for optional custom configuration values
  /// The custom message for a request timeout scenario.
  final String? customRequestTimeoutMessage;

  /// The custom message for network issues.
  final String? customNetworkIssuesMessage;

  /// The custom message for a generic error.
  final String? customErrorMessage;

  // Private constructor to ensure instantiation only through the factory method
  const ApiResponseConfig._({
    this.customRequestTimeoutMessage,
    this.customNetworkIssuesMessage,
    this.customErrorMessage,
  });

  // Static method to update the global configuration with custom values
  /// Updates the global configuration with custom messages for API response scenarios.
  ///
  /// **Parameters:**
  /// - `customConfig`: An instance of `ApiResponseConfig` containing custom messages.
  ///
  /// **Example:**
  /// ```dart
  /// ApiResponseConfig.instantiate(
  ///   ApiResponseConfig(
  ///     customRequestTimeoutMessage: 'Request took too long.',
  ///     customNetworkIssuesMessage: 'No internet detected.',
  ///   ),
  /// );
  /// ```
  static Future<void> instantiate(ApiResponseConfig customConfig) async {
    _requestTimeoutMessage =
        customConfig.customRequestTimeoutMessage ?? _requestTimeoutMessage;
    _networkIssuesMessage =
        customConfig.customNetworkIssuesMessage ?? _networkIssuesMessage;
    _errorMessage = customConfig.customErrorMessage ?? _errorMessage;
  }

  // Static method to reset the configuration to default values
  /// Resets the global configuration to default values for API response messages.
  static void resetToDefaults() {
    _requestTimeoutMessage = 'The request timed out. Please try again later.';
    _networkIssuesMessage =
        'Network issues detected. Please check your connection.';
    _errorMessage = 'An error occurred. Please try again later.';
  }

  // Factory constructor for creating a new `ApiResponseConfig` instance with custom values
  /// Creates an instance of `ApiResponseConfig` with optional custom messages.
  ///
  /// **Parameters:**
  /// - `customRequestTimeoutMessage`: Custom message for request timeout.
  /// - `customNetworkIssuesMessage`: Custom message for network issues.
  /// - `customErrorMessage`: Custom message for a generic error.
  factory ApiResponseConfig({
    String? customRequestTimeoutMessage,
    String? customNetworkIssuesMessage,
    String? customErrorMessage,
  }) {
    return ApiResponseConfig._(
      customRequestTimeoutMessage: customRequestTimeoutMessage,
      customNetworkIssuesMessage: customNetworkIssuesMessage,
      customErrorMessage: customErrorMessage,
    );
  }

  // Public getter for the request timeout message
  static String get requestTimeoutMessage => _requestTimeoutMessage;

  // Public getter for the network issues message
  static String get networkIssuesMessage => _networkIssuesMessage;

  // Public getter for the generic error message
  static String get errorMessage => _errorMessage;

  // Override Equatable's props to enable comparison based on instance fields
  @override
  List<Object?> get props => [
        customRequestTimeoutMessage,
        customNetworkIssuesMessage,
        customErrorMessage,
      ];
}
