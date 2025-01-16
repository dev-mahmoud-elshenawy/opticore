part of '../config_import.dart';

/// [NetworkConfig] is a configuration class designed to manage network-related
/// settings, specifically focusing on HTTP headers. It provides methods for
/// updating, resetting, and accessing global headers used across network requests
/// throughout the application, ensuring consistent and dynamic management of headers.
///
/// **Key Features:**
/// - Dynamically update global HTTP headers.
/// - Reset headers to their default values.
/// - Provide an immutable view of the current headers to ensure data integrity and safety from external modifications.
/// - Allows for easy management of network configurations in a centralized way.
///
/// **Usage Example:**
/// ```dart
/// // Update the headers with new values
/// NetworkConfig.updateHeaders({'Authorization': 'Bearer token123'});
///
/// // Access the current headers
/// print(NetworkConfig.headers);
///
/// // Reset headers to their default (empty) state
/// NetworkConfig.resetHeadersToDefault();
/// ```
class NetworkConfig extends Equatable {
  // Private static field for global default headers configuration
  /// A private static map that holds the default headers used in network requests.
  /// This map can be modified globally through the `updateHeaders` method to add or update custom headers.
  ///
  /// It is important to note that this map is shared across the entire application and is used as the default
  /// set of headers for network requests unless otherwise specified.
  static Map<String, String> _headers = {};

  // Static method to update headers globally and return the updated headers
  /// This method allows you to update the global headers by merging the provided `newHeaders`
  /// with the existing ones. If no new headers are provided, the current headers are returned unchanged.
  ///
  /// **Parameters:**
  /// - `newHeaders`: A map containing the new headers to be added or updated in the global headers.
  ///   If `null` is passed, the current headers remain unchanged.
  ///
  /// **Returns:**
  /// - A [Future<Map<String, String>>] representing the updated global headers,
  ///   after merging the existing and new headers.
  ///
  /// **Example:**
  /// ```dart
  /// var updatedHeaders = await NetworkConfig.updateHeaders({
  ///   'Authorization': 'Bearer newToken',
  /// });
  /// print(updatedHeaders);
  /// ```
  static Future<Map<String, String>> updateHeaders(
    Map<String, String>? newHeaders,
  ) async {
    // Return current headers if no new headers are provided
    if (newHeaders == null) return _headers;

    // Merge custom headers directly with existing headers, ensuring non-null values
    final Map<String, String> filteredHeaders = Map<String, String>.fromEntries(
      newHeaders.entries.map(
        (entry) => MapEntry(entry.key, entry.value),
      ),
    );

    // Update the global headers map with the new headers
    _headers.addAll(filteredHeaders);

    // Return the updated headers
    return _headers;
  }

  // Static method to reset headers to their default (empty) state
  /// Resets the global headers to an empty map, effectively clearing any custom headers
  /// that have been added. This method can be used to revert the headers back to their default state.
  ///
  /// **Usage**: This method is useful when you need to clear any modifications to the headers
  /// and restore the default (empty) headers configuration.
  static void resetHeadersToDefault() {
    _headers = {};
  }

  // Public getter to access the current headers
  /// This getter provides an immutable view of the current global headers.
  /// By using this getter, external code can safely access the headers without modifying them.
  ///
  /// **Returns:**
  /// - An unmodifiable [Map<String, String>] representing the current headers in their current state.
  ///
  /// **Example:**
  /// ```dart
  /// var currentHeaders = NetworkConfig.headers;
  /// print(currentHeaders);
  /// ```
  static Map<String, String> get headers => Map.unmodifiable(_headers);

  // Override props to include the instance fields you want to compare
  /// This method is used for comparing instances of [NetworkConfig] in tests or when performing
  /// equality checks. It ensures that the state of the headers is taken into account when
  /// comparing two [NetworkConfig] instances.
  @override
  List<Object?> get props => [
        _headers,
      ];
}
