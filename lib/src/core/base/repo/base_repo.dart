part of '../import/base_import.dart';

/// A base repository class that provides core functionality for interacting
/// with network services. It manages network-related operations and offers
/// mechanisms to update global headers.
///
/// The class contains a method for updating HTTP headers and a mechanism
/// to handle the cleanup of resources when the repository is disposed.
///
/// ### Key Features:
/// - **Header Management:** Allows updating of global headers used in network requests.
/// - **Network Helper:** Uses a `NetworkHelper` instance for managing network operations.
/// - **Customizable Header Update:** Supports a callback function to customize the header update logic.
///
/// ### Example Usage:
/// To use the `BaseRepo` class, extend it in your repository classes:
///
/// ```dart
/// class UserRepository extends BaseRepo {
///   Future<User> getUserDetails() async {
///     // Example network request logic using updated headers
///     await updateHeaders(onUpdate: myHeaderUpdateCallback);
///     // Perform network operation...
///   }
/// }
/// ```
typedef HeaderUpdateCallback = Future<Map<String, String>> Function(
  Map<String, String> headers,
);

/// A base class for all repository classes that handles network operations.
/// It provides functionality for managing network headers and performing
/// cleanup during disposal.
///
/// - [networkHelper]: An instance of `NetworkHelper` used to manage network operations.
/// - [updateHeaders]: Updates global headers with the provided callback function,
///   allowing dynamic customization of the headers.
abstract class BaseRepo {
  NetworkHelper? networkHelper;

  /// Constructor that initializes the `networkHelper` instance.
  BaseRepo() {
    networkHelper = NetworkHelper();
  }

  /// Updates global headers by calling a custom callback function to
  /// modify the current headers.
  ///
  /// The callback function allows the headers to be modified dynamically
  /// before they are applied globally in the `NetworkConfig` and in the
  /// network helper's Dio instance.
  ///
  /// - [onUpdate]: A callback function that receives the current headers
  ///   and returns the updated headers as a `Map<String, String>`.
  ///   The callback is optional, and if not provided, the headers will
  ///   remain unchanged.
  ///
  /// Returns a boolean indicating whether the headers were successfully updated.
  ///
  /// ### Examples:
  ///
  /// **Example 1:** Adding an authorization token:
  /// ```dart
  /// await updateHeaders(
  ///   onUpdate: (headers) async {
  ///     // Add a new authorization header or update existing one
  ///     headers['Authorization'] = 'Bearer $token';
  ///     return headers;
  ///   },
  /// );
  /// ```
  ///
  /// **Example 2:** Updating multiple headers:
  /// ```dart
  /// await updateHeaders(
  ///   onUpdate: (headers) async {
  ///     headers['Content-Type'] = 'application/json';
  ///     headers['Accept-Language'] = 'en-US';
  ///     return headers;
  ///   },
  /// );
  /// ```
  ///
  /// **Example 3:** Removing a specific header:
  /// ```dart
  /// await updateHeaders(
  ///   onUpdate: (headers) async {
  ///     headers.remove('Authorization'); // Remove auth when logging out
  ///     return headers;
  ///   },
  /// );
  /// ```
  ///
  /// Note: The method both updates existing headers and adds new ones if they
  /// don't already exist. If you need to remove a header, use the `remove`
  /// method on the headers map as shown in Example 3.
  Future<bool> updateHeaders({
    HeaderUpdateCallback? onUpdate,
  }) async {
    try {
      if (onUpdate != null) {
        // Create a modifiable copy of the current headers
        Map<String, String> headersCopy =
            Map<String, String>.from(NetworkConfig.headers);

        // Get the updated headers from the callback
        Map<String, String> updatedHeaders = await onUpdate(headersCopy);

        // Update the global headers in NetworkConfig
        await NetworkConfig.updateHeaders(newHeaders: updatedHeaders);

        // Update the headers in the NetworkHelper
        if (networkHelper != null) {
          networkHelper!.updateHeaders(updatedHeaders);
        }

        Logger.info("Headers updated successfully");
        return true;
      }
      return false;
    } catch (e, stackTrace) {
      Logger.error("Failed to update headers: $e\n$stackTrace");
      return false;
    }
  }
}
