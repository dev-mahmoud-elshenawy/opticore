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
  /// before they are applied globally in the `NetworkConfig`.
  ///
  /// - [onUpdate]: A callback function that receives the current headers
  ///   and returns the updated headers as a `Map<String, String>`.
  ///   The callback is optional, and if not provided, the headers will
  ///   remain unchanged.
  ///
  /// ### Example:
  /// ```dart
  ///   @override
  ///   Future<void> updateHeaders({
  ///     HeaderUpdateCallback? onUpdate,
  ///   }) async {
  ///     // Call the super implementation for default behavior
  ///     await super.updateHeaders(onUpdate: (headers) async {
  ///       headers['Authorization'] = 'Bearer my_new_token';
  ///       return headers;
  ///     });
  ///
  ///     // Additional logic for custom behavior (e.g., logging)
  ///     print("Headers have been updated in CustomRepo.");
  ///   }
  /// ```
  Future<void> updateHeaders({
    HeaderUpdateCallback? onUpdate,
  }) async {
    if (onUpdate != null) {
      // Get the new headers from the callback
      Map<String, String> updatedHeaders =
          await onUpdate(NetworkConfig.headers);

      // Update the global headers in NetworkConfig
      await NetworkConfig.updateHeaders(updatedHeaders);
    }
  }
}
